"
I define the public API needed to be used by the Universe and the Spaces.
I define the public API that Host Spaces must provide.
This API is mostly used by  the Universe and the Host-Independent Spaces.
An Host Space is an  actual screen area provided by the underlying Host.
This area is typically an host-specific window.
"
Trait {
	#name : #TBlHostSpace,
	#instVars : [
		'host',
		'space',
		'universe',
		'renderer'
	],
	#category : #'Bloc-Universe - Host'
}

{ #category : #'host space - displaying' }
TBlHostSpace >> close [

	self explicitRequirement
]

{ #category : #'host space - cursor' }
TBlHostSpace >> cursor: aCursor [
	"Change current cursor image/view to the given one."

	self explicitRequirement
]

{ #category : #'host space - geometry' }
TBlHostSpace >> densityDpi [
	"Return the screen density expressed as the number of dots-per-inch."
	
	^ self explicitRequirement
]

{ #category : #'host space - accessing' }
TBlHostSpace >> detachHost [

	host := nil
]

{ #category : #'host space - accessing' }
TBlHostSpace >> detachSpace [

	space := nil
]

{ #category : #'host space - accessing' }
TBlHostSpace >> detachUniverse [

	universe := nil
]

{ #category : #'host space - events' }
TBlHostSpace >> enqueueEvent: aBlEvent [
	"I dispatch events directly to the universe or space as soon as they come"

	aBlEvent isUniverseEvent
		ifTrue: [ ^ self universe dispatchEvent: aBlEvent ].

	aBlEvent isSpaceEvent
		ifTrue: [ ^ self space dispatchEvent: aBlEvent ].

	self space dispatchEvent: aBlEvent
]

{ #category : #'host space - events' }
TBlHostSpace >> fetchedEventsDo: aBlock [
	"Flush event queue and evaluate a given block with every queued event as argument"
]

{ #category : #'host space - events' }
TBlHostSpace >> generateEvents [
	"Generate more complex state change events such as window scale event when resolution of the screen changes"
]

{ #category : #'host space - testing' }
TBlHostSpace >> hasResized [
	"Return true if renderer extent changed.
	It may happen if window moved between displays with different DPI,
	e.g. from normal display to Retina."

	^ self renderer hasResized: self
]

{ #category : #'host space - accessing' }
TBlHostSpace >> host [
	"Return a host that was used to create this host space"

	^ host
]

{ #category : #'host space - accessing' }
TBlHostSpace >> host: aBlHost [
	"Assign a host that was used to create this host space"
	
	host := aBlHost
]

{ #category : #initialization }
TBlHostSpace >> initializeRenderer [

	renderer initializeForHostSpace: self
]

{ #category : #'host space - testing' }
TBlHostSpace >> isVisible [
	"Return true if underlying window is shown, false otherwise.
	Note: If window was shown and then minimized it is still considered to be visible.
	Window can become invisible by asking it to hide"

	^ self explicitRequirement
]

{ #category : #'host space - geometry' }
TBlHostSpace >> logicalSize [
	"Returns the logical size of the host's client area (instance of `BlLogicalDisplaySize`).
	The client area is the content of the window, excluding the title bar and borders.
	Converting the returned LogicalSize to PhysicalSize produces the size your framebuffer should be."

	^ self explicitRequirement
]

{ #category : #'host space - displaying' }
TBlHostSpace >> maximize [

	self explicitRequirement
]

{ #category : #'host space - displaying' }
TBlHostSpace >> maximized [

	^ self explicitRequirement
]

{ #category : #'host space - displaying' }
TBlHostSpace >> minimize [

	self explicitRequirement
]

{ #category : #'host space - displaying' }
TBlHostSpace >> minimized [

	^ self explicitRequirement
]

{ #category : #'host space - testing' }
TBlHostSpace >> needsRebuild [
	"Return true if window should be recreated after user saved and quit Pharo."
	
	^ self explicitRequirement
]

{ #category : #'host space - geometry' }
TBlHostSpace >> physicalSize [
	"Return a physical host size which is what the framebuffer size should be (Instance of `BlPhysicalDisplaySize`).
	This size may differ from the logical size on high DPI (Retina) screens.
	For example, physical size is x2 larger than logical size."

	^ self explicitRequirement
]

{ #category : #'host space - rendering' }
TBlHostSpace >> render: aSpace [
	"Render a given abstract space on an underlying window or visual area"

	self renderer render: self
]

{ #category : #'host space - accessing' }
TBlHostSpace >> renderer [
	"Return the host renderer used to render the elements of my spaces."

	^ renderer
]

{ #category : #'host space - accessing' }
TBlHostSpace >> renderer: aBlHostRenderer [

	renderer := aBlHostRenderer
]

{ #category : #'host space - rendering' }
TBlHostSpace >> requestRedraw [
	"Space needs to redraw the window"
]

{ #category : #'host space - geometry' }
TBlHostSpace >> scaleFactor [
	"Return a scaling dpi factor from logical to physical coordinates.
	On high DPI displays, scaling factor is > 1."

	| aPhysicalSize aLogicalSize aWidthScale aHeightScale |
	aPhysicalSize := self physicalSize.
	aLogicalSize := self logicalSize.
	
	(aPhysicalSize isZero
		or: [ aLogicalSize isZero ])
		ifTrue: [ ^ 1 ].

	aWidthScale := (aPhysicalSize width / aLogicalSize width) asFloat.
	aHeightScale := (aPhysicalSize height / aLogicalSize height) asFloat.
	
	(aWidthScale closeTo: aHeightScale epsilon: 0.1)
		ifFalse: [ NonInteractiveTranscript stdout
			show: ('DPI factor is different for width {1} and height {2}' format: { aWidthScale . aHeightScale });
			cr ].

	^ aWidthScale
]

{ #category : #'host space - displaying' }
TBlHostSpace >> show [

	self explicitRequirement
]

{ #category : #'host space - accessing' }
TBlHostSpace >> space [
	"Return a space I am assigned to."

	^ space
]

{ #category : #'host space - accessing' }
TBlHostSpace >> space: aSpace [
	"Assign me to a given space."

	space := aSpace
]

{ #category : #'host space - displaying' }
TBlHostSpace >> toBack [

	self explicitRequirement
]

{ #category : #'host space - displaying' }
TBlHostSpace >> toFront [

	self explicitRequirement
]

{ #category : #'host space - accessing' }
TBlHostSpace >> universe [

	^ universe
]

{ #category : #'host space - accessing' }
TBlHostSpace >> universe: aBlParallelUniverse [

	universe := aBlParallelUniverse
]

{ #category : #'host space - geometry' }
TBlHostSpace >> windowExtent: anExtent [

	self explicitRequirement
]
