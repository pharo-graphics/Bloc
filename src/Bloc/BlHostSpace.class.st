"
I am an adapter between the Universe and the Spaces.

I define the public API that Host Spaces must provide.
This API is mostly used by the Universe and the Host-Independent Spaces.
An Host Space is an actual screen area provided by the underlying Host.
This area is typically an host-specific window.
"
Class {
	#name : #BlHostSpace,
	#superclass : #Object,
	#instVars : [
		'host',
		'space',
		'universe',
		'renderer'
	],
	#category : #'Bloc-Universe - Host'
}

{ #category : #'host space - displaying' }
BlHostSpace >> close [

	self subclassResponsibility
]

{ #category : #'host space - cursor' }
BlHostSpace >> cursor: aCursor [
	"Change current cursor image/view to the given one."

	self subclassResponsibility
]

{ #category : #'host space - geometry' }
BlHostSpace >> densityDpi [
	"Return the screen density expressed as the number of dots-per-inch."
	
	^ self subclassResponsibility
]

{ #category : #'host space - events' }
BlHostSpace >> enqueueEvent: aBlEvent [
	"I dispatch events directly to the universe or space as soon as they come"

	aBlEvent isUniverseEvent
		ifTrue: [ ^ self universe dispatchEvent: aBlEvent ].

	aBlEvent isSpaceEvent
		ifTrue: [ ^ self space dispatchEvent: aBlEvent ].

	self space dispatchEvent: aBlEvent
]

{ #category : #'host space - events' }
BlHostSpace >> fetchedEventsDo: aBlock [
	"Flush event queue and evaluate a given block with every queued event as argument"
]

{ #category : #'host space - events' }
BlHostSpace >> generateEvents [
	"Generate more complex state change events such as window scale event when resolution of the screen changes"
]

{ #category : #'host space - testing' }
BlHostSpace >> hasResized [
	"Return true if renderer extent changed.
	It may happen if window moved between displays with different DPI,
	e.g. from normal display to Retina."

	^ self renderer hasResized: self
]

{ #category : #'host space - accessing' }
BlHostSpace >> host [
	"Return a host that was used to create this host space"

	^ host
]

{ #category : #'host space - accessing' }
BlHostSpace >> host: aBlHost [
	"Assign a host that was used to create this host space"
	
	host := aBlHost
]

{ #category : #initialization }
BlHostSpace >> initializeRenderer [

	renderer initializeForHostSpace: self
]

{ #category : #'host space - testing' }
BlHostSpace >> isValid [
	
	^ true
]

{ #category : #'host space - testing' }
BlHostSpace >> isVisible [
	"Return true if underlying window is shown, false otherwise.
	Note: If window was shown and then minimized it is still considered to be visible.
	Window can become invisible by asking it to hide"

	^ self subclassResponsibility
]

{ #category : #'host space - geometry' }
BlHostSpace >> logicalSize [
	"Returns the logical size of the host's client area (instance of `BlLogicalDisplaySize`).
	The client area is the content of the window, excluding the title bar and borders.
	Converting the returned LogicalSize to PhysicalSize produces the size your framebuffer should be."

	^ self subclassResponsibility
]

{ #category : #'host space - displaying' }
BlHostSpace >> maximize [

	self subclassResponsibility
]

{ #category : #'host space - displaying' }
BlHostSpace >> maximized [

	^ self subclassResponsibility
]

{ #category : #'host space - displaying' }
BlHostSpace >> minimize [

	self subclassResponsibility
]

{ #category : #'host space - displaying' }
BlHostSpace >> minimized [

	^ self subclassResponsibility
]

{ #category : #'host space - displaying' }
BlHostSpace >> open [

	self show
]

{ #category : #'host space - geometry' }
BlHostSpace >> physicalSize [
	"Return a physical host size which is what the framebuffer size should be (Instance of `BlPhysicalDisplaySize`).
	This size may differ from the logical size on high DPI (Retina) screens.
	For example, physical size is x2 larger than logical size."

	^ self subclassResponsibility
]

{ #category : #'host space - rendering' }
BlHostSpace >> render: aSpace [
	"Render a given abstract space on an underlying window or visual area"

	self renderer render: self
]

{ #category : #'host space - accessing' }
BlHostSpace >> renderer [
	"Return the host renderer used to render the elements of my spaces."

	^ renderer
]

{ #category : #'host space - accessing' }
BlHostSpace >> renderer: aBlHostRenderer [

	renderer := aBlHostRenderer
]

{ #category : #'host space - rendering' }
BlHostSpace >> requestRedraw [
	"Space needs to redraw the window"
]

{ #category : #'host space - geometry' }
BlHostSpace >> scaleFactor [
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
BlHostSpace >> show [

	self subclassResponsibility
]

{ #category : #'host space - accessing' }
BlHostSpace >> space [
	"Return a space I am assigned to."

	^ space
]

{ #category : #'host space - accessing' }
BlHostSpace >> space: aSpace [
	"Assign me to a given space."

	space := aSpace
]

{ #category : #'host space - displaying' }
BlHostSpace >> tearDown [

	self close.
	space := nil.
	host := nil.
	universe := nil
]

{ #category : #'host space - displaying' }
BlHostSpace >> toBack [

	self subclassResponsibility
]

{ #category : #'host space - displaying' }
BlHostSpace >> toFront [

	self subclassResponsibility
]

{ #category : #'host space - accessing' }
BlHostSpace >> universe [

	^ universe
]

{ #category : #'host space - accessing' }
BlHostSpace >> universe: aBlParallelUniverse [

	universe := aBlParallelUniverse
]

{ #category : #'host space - geometry' }
BlHostSpace >> windowExtent: anExtent [

	self subclassResponsibility
]
