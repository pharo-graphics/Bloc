"
I am a fallback host space that is chosen if there are no other available and supported hosts.

"
Class {
	#name : #BlHeadlessHostSpace,
	#superclass : #Object,
	#traits : 'TBlHostSpace + TBlSpaceProperties',
	#classTraits : 'TBlHostSpace classTrait + TBlSpaceProperties classTrait',
	#instVars : [
		'eventFetcher',
		'position',
		'title'
	],
	#category : #'Bloc-Universe - Host Headless'
}

{ #category : #'window - properties' }
BlHeadlessHostSpace >> borderless: aBoolean [
	"Make host window borderless if true is given"
]

{ #category : #'host space - displaying' }
BlHeadlessHostSpace >> close [
	"do nothing"
]

{ #category : #'host space - cursor' }
BlHeadlessHostSpace >> cursor: aCursor [
	"Change current cursor image/view to the given one"
]

{ #category : #'host space - geometry' }
BlHeadlessHostSpace >> densityDpi [
	"Return the screen density expressed as dots-per-inch (a float)"
	
	^ 96.0
]

{ #category : #'window - properties' }
BlHeadlessHostSpace >> fullscreen: aBoolean [
	"Switch underlying window to fullscreen if true is given
	and exit fullscreen mode if false is given"
]

{ #category : #'window - properties' }
BlHeadlessHostSpace >> fullsize: aBoolean [
	"Switch underlying window to fullsize if true is given
	and exit fullsize mode if false is given.
	See ${method:TBlSpaceProperties>>#fullsize}"
]

{ #category : #'host space - displaying' }
BlHeadlessHostSpace >> hide [
	"do nothing"
]

{ #category : #'window - properties' }
BlHeadlessHostSpace >> icon: aForm [
	"Change window's icon to the given one"
]

{ #category : #initialization }
BlHeadlessHostSpace >> initialize [

	super initialize.

	eventFetcher := BlHostEventFetcher hostSpace: self
]

{ #category : #'window - properties' }
BlHeadlessHostSpace >> isBorderless [
	"Return true if underlying window is now borderless, false otherwise"
	
	^ false
]

{ #category : #'window - properties' }
BlHeadlessHostSpace >> isFullscreen [
	"Return true if the underlying window is in fullscreen mode, false otherwise."

	^ false
]

{ #category : #'window - properties' }
BlHeadlessHostSpace >> isFullsize [
	"Return true if the underlying window is in fullsize mode, false otherwise."

	^ false
]

{ #category : #'window - properties' }
BlHeadlessHostSpace >> isResizable [
	"Return true if the underlying window is resizable, false otherwise."

	^ true
]

{ #category : #testing }
BlHeadlessHostSpace >> isValid [
	
	^ true
]

{ #category : #'host space - testing' }
BlHeadlessHostSpace >> isVisible [
	"Return true if underlying window is shown, false otherwise.
	Note: If window was shown and then minimized it is still considered to be visible.
	Window can become invisible by asking it to hide"

	^ false
]

{ #category : #'host space - geometry' }
BlHeadlessHostSpace >> logicalSize [
	"Returns the logical size of the host's client area.
	The client area is the content of the window, excluding the title bar and borders.
	Converting the returned LogicalSize to PhysicalSize produces the size your framebuffer should be."

	^ BlLogicalDisplaySize width: 0 height: 0
]

{ #category : #'host space - displaying' }
BlHeadlessHostSpace >> maximize [
	"do nothing"
]

{ #category : #'host space - displaying' }
BlHeadlessHostSpace >> maximized [

	^ false
]

{ #category : #'host space - displaying' }
BlHeadlessHostSpace >> minimize [
	"do nothing"
]

{ #category : #'host space - displaying' }
BlHeadlessHostSpace >> minimized [

	^ false
]

{ #category : #'host space - testing' }
BlHeadlessHostSpace >> needsRebuild [
	"Return true if window should be recreated after user saved and quit pharo"
	
	^ false
]

{ #category : #initialization }
BlHeadlessHostSpace >> newSurfaceRenderer [
	
	^ BlHeadlessBufferSurfaceRenderer new
]

{ #category : #'host space - displaying' }
BlHeadlessHostSpace >> open [
	"do nothing"
]

{ #category : #'host space - geometry' }
BlHeadlessHostSpace >> physicalSize [
	"Return a physical host size which is what the framebuffer size should be.
	This size may differ from the logical size on high-DPI (Retina) screens.
	In most cases physical size is x2 larger than logical size on retina screens."

	^ BlPhysicalDisplaySize width: 0 height: 0
]

{ #category : #'window - properties' }
BlHeadlessHostSpace >> position [
	"Return window's position in screen coordinates"
	
	^ position
]

{ #category : #'window - properties' }
BlHeadlessHostSpace >> position: aPoint [
	"Change window's position to a given point in screen coordinates"
	
	position := aPoint

]

{ #category : #'host space - drawing' }
BlHeadlessHostSpace >> render: aSpace [
	"Render a given abstract space on an underlying window or visual area"
]

{ #category : #'window - properties' }
BlHeadlessHostSpace >> resizable: aBoolean [
	"Make underlying window resizable if true is given"
]

{ #category : #'host space - displaying' }
BlHeadlessHostSpace >> show [
]

{ #category : #'window - properties' }
BlHeadlessHostSpace >> title [
	"Return window's title as a string"

	^ title
]

{ #category : #'window - properties' }
BlHeadlessHostSpace >> title: aString [
	"Change window's title"

	title := aString
]

{ #category : #'host space - displaying' }
BlHeadlessHostSpace >> toBack [
	"do nothing"
]

{ #category : #'host space - displaying' }
BlHeadlessHostSpace >> toFront [
	"do nothing"
]

{ #category : #'host space - accessing' }
BlHeadlessHostSpace >> universe [

	^ universe
]

{ #category : #'host space - geometry' }
BlHeadlessHostSpace >> windowExtent: anExtent [
	
]
