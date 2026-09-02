"
I am an in-memory host space that supports window properties and layout measurement without opening an OS display window.
"
Class {
	#name : #BlHeadlessHostSpace,
	#superclass : #BlHostSpace,
	#traits : 'TBlSpaceProperties',
	#classTraits : 'TBlSpaceProperties classTrait',
	#instVars : [
		'physicalSize',
		'logicalSize',
		'minimized',
		'maximized',
		'isFullscreen',
		'isFullsize',
		'borderless',
		'position',
		'title',
		'opened',
		'cursor',
		'renderCount',
		'visible'
	],
	#category : #'Bloc-Universe - Host Headless'
}

{ #category : #'window - properties' }
BlHeadlessHostSpace >> borderless: aBoolean [
	"Make host window borderless if true is given"

	borderless := aBoolean
]

{ #category : #'host space - accessing' }
BlHeadlessHostSpace >> canvasExtent: anExtent [
	physicalSize := (anExtent x @ anExtent y) asPhysicalSize
]

{ #category : #'host space - displaying' }
BlHeadlessHostSpace >> close [
	opened := false.
	self hide
]

{ #category : #'host space - cursor' }
BlHeadlessHostSpace >> cursor [
	^ cursor
]

{ #category : #'host space - cursor' }
BlHeadlessHostSpace >> cursor: aCursor [
	"Change current cursor image/view to the given one"

	cursor := aCursor
]

{ #category : #initialization }
BlHeadlessHostSpace >> defaultLogicalSize [
	^ (400 @ 300) asLogicalSize
]

{ #category : #initialization }
BlHeadlessHostSpace >> defaultPhysicalSize [
	^ 800 @ 600
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

	isFullscreen := aBoolean
]

{ #category : #'window - properties' }
BlHeadlessHostSpace >> fullsize: aBoolean [
	"Switch underlying window to fullsize if true is given
	and exit fullsize mode if false is given.
	See ${method:TBlSpaceProperties>>#fullsize}"

	isFullsize := aBoolean
]

{ #category : #'host space - testing' }
BlHeadlessHostSpace >> hasResized [

	^ false
]

{ #category : #'host space - displaying' }
BlHeadlessHostSpace >> hide [
	visible := false
]

{ #category : #'window - properties' }
BlHeadlessHostSpace >> icon: aForm [
	"Change window's icon to the given one"
]

{ #category : #initialization }
BlHeadlessHostSpace >> initialize [

	super initialize.

	visible := false.
	minimized := false.
	maximized := false.
	borderless := false.
	opened := false.

	physicalSize := self defaultPhysicalSize.
	logicalSize := self defaultLogicalSize.
	renderCount := 0
]

{ #category : #'dirty areas' }
BlHeadlessHostSpace >> invalidate [
	"Ignore it"
]

{ #category : #'window - properties' }
BlHeadlessHostSpace >> isBorderless [
	"Return true if underlying window is now borderless, false otherwise"
	
	^ borderless
]

{ #category : #'window - properties' }
BlHeadlessHostSpace >> isFullscreen [
	"Return true if the underlying window is in fullscreen mode, false otherwise."

	^ isFullscreen
]

{ #category : #'window - properties' }
BlHeadlessHostSpace >> isFullsize [
	"Return true if the underlying window is in fullsize mode, false otherwise."

	^ isFullsize
]

{ #category : #'host space - testing' }
BlHeadlessHostSpace >> isVisible [
	"Return true if underlying window is shown, false otherwise.
	Note: If window was shown and then minimized it is still considered to be visible.
	Window can become invisible by asking it to hide"

	^ visible
]

{ #category : #'host space - geometry' }
BlHeadlessHostSpace >> logicalSize [
	"Returns the logical size of the host's client area.
	The client area is the content of the window, excluding the title bar and borders.
	Converting the returned LogicalSize to PhysicalSize produces the size your framebuffer should be."

	^ logicalSize
]

{ #category : #'host space - displaying' }
BlHeadlessHostSpace >> maximize [

	maximized := true.
	minimized := false
]

{ #category : #'host space - displaying' }
BlHeadlessHostSpace >> maximized [

	^ maximized
]

{ #category : #'host space - displaying' }
BlHeadlessHostSpace >> minimize [

	maximized := false.
	minimized := true
]

{ #category : #'host space - displaying' }
BlHeadlessHostSpace >> minimized [

	^ minimized
]

{ #category : #'host space - displaying' }
BlHeadlessHostSpace >> open [
	opened := true.
	self show
]

{ #category : #'host space - geometry' }
BlHeadlessHostSpace >> physicalSize [
	"Return a physical host size which is what the framebuffer size should be.
	This size may differ from the logical size on high-DPI (Retina) screens.
	In most cases physical size is x2 larger than logical size on retina screens."

	^ physicalSize
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

{ #category : #'host space - rendering' }
BlHeadlessHostSpace >> render: aSpace [
	"Render a given abstract space on an underlying window or visual area"

	renderCount := renderCount + 1.
	aSpace clearDirtyElements
]

{ #category : #'host space - accessing' }
BlHeadlessHostSpace >> renderCount [
	"Return how many times my render: method was executed"

	^ renderCount
]

{ #category : #'host space - displaying' }
BlHeadlessHostSpace >> show [
	visible := true
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

{ #category : #'host space - geometry' }
BlHeadlessHostSpace >> windowExtent: anExtent [
	logicalSize := anExtent asLogicalSize
]
