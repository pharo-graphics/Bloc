"
I am a mocked host space that behaves just like a real one but is invisible and does not render anything

"
Class {
	#name : #BlMockedHostSpace,
	#superclass : #BlHostSpace,
	#traits : 'TBlSpaceProperties',
	#classTraits : 'TBlSpaceProperties classTrait',
	#instVars : [
		'borderless',
		'cursor',
		'maximized',
		'minimized',
		'visible',
		'opened',
		'densityDpi',
		'renderCount',
		'isFullscreen',
		'position',
		'title',
		'isFullsize',
		'physicalSize',
		'logicalSize'
	],
	#category : #'BlocHost-Mock-Host'
}

{ #category : #'window - properties' }
BlMockedHostSpace >> borderless: aBoolean [
	"Make host window borderless if true is given"

	borderless := aBoolean
]

{ #category : #'host space - accessing' }
BlMockedHostSpace >> canvasExtent: anExtent [
	physicalSize := (anExtent x @ anExtent y) asPhysicalSize
]

{ #category : #'host space - displaying' }
BlMockedHostSpace >> close [
	opened := false.
	self hide
]

{ #category : #'host space - cursor' }
BlMockedHostSpace >> cursor [
	^ cursor
]

{ #category : #'host space - cursor' }
BlMockedHostSpace >> cursor: aCursor [
	"Change current cursor image/view to the given one"

	cursor := aCursor
]

{ #category : #initialization }
BlMockedHostSpace >> defaultDensityDpi [
	^ 96.0
]

{ #category : #initialization }
BlMockedHostSpace >> defaultLogicalSize [
	^ (400 @ 300) asLogicalSize
]

{ #category : #initialization }
BlMockedHostSpace >> defaultPhysicalSize [
	^ 800 @ 600
]

{ #category : #'host space - geometry' }
BlMockedHostSpace >> densityDpi [
	"Return the screen density expressed as dots-per-inch (a float)"
	
	^ densityDpi
]

{ #category : #'host space - accessing' }
BlMockedHostSpace >> densityDpi: aNumber [
	densityDpi := aNumber
]

{ #category : #'window - properties' }
BlMockedHostSpace >> fullscreen: aBoolean [
	"Switch underlying window to fullscreen if true is given
	and exit fullscreen mode if false is given"

	isFullscreen := aBoolean
]

{ #category : #'window - properties' }
BlMockedHostSpace >> fullsize: aBoolean [
	"Switch underlying window to fullsize if true is given
	and exit fullsize mode if false is given.
	See ${method:TBlSpaceProperties>>#fullsize}"

	isFullsize := aBoolean
]

{ #category : #'host space - testing' }
BlMockedHostSpace >> hasResized [
	"Return true if renderer extent changed.
	It may happen if window moved between displays with different dpi,
	e.g. from normal display to retina"
	<return: #Boolean>

	^ false
]

{ #category : #'host space - displaying' }
BlMockedHostSpace >> hide [
	visible := false
]

{ #category : #'window - properties' }
BlMockedHostSpace >> icon: aForm [
	"Change window's icon to the given one"
]

{ #category : #initialization }
BlMockedHostSpace >> initialize [

	super initialize.

	visible := false.
	minimized := false.
	maximized := false.
	borderless := false.
	opened := false.

	physicalSize := self defaultPhysicalSize.
	logicalSize := self defaultLogicalSize.
	densityDpi := self defaultDensityDpi.
	renderCount := 0
]

{ #category : #'window - properties' }
BlMockedHostSpace >> isBorderless [
	"Return true if underlying window is now borderless, false otherwise"
	
	^ borderless
]

{ #category : #'window - properties' }
BlMockedHostSpace >> isFullscreen [
	"Return true if an underlying window is in fullscreen mode, false otherwise."

	^ isFullscreen
]

{ #category : #'window - properties' }
BlMockedHostSpace >> isFullsize [
	"Return true if an underlying window is in fullsize mode, false otherwise."

	^ isFullsize
]

{ #category : #'host space - testing' }
BlMockedHostSpace >> isVisible [
	"Return true if underlying window is shown, false otherwise.
	Note: If window was shown and then minimized it is still considered to be visible.
	Window can become invisible by asking it to hide"
	<return: #Boolean>

	^ visible
]

{ #category : #'host space - geometry' }
BlMockedHostSpace >> logicalSize [
	"Returns the logical size of the host's client area.
	The client area is the content of the window, excluding the title bar and borders.
	Converting the returned LogicalSize to PhysicalSize produces the size your framebuffer should be."

	^ logicalSize
]

{ #category : #'host space - displaying' }
BlMockedHostSpace >> maximize [

	maximized := true.
	minimized := false
]

{ #category : #'host space - displaying' }
BlMockedHostSpace >> maximized [

	^ maximized
]

{ #category : #'host space - displaying' }
BlMockedHostSpace >> minimize [

	maximized := false.
	minimized := true
]

{ #category : #'host space - displaying' }
BlMockedHostSpace >> minimized [

	^ minimized
]

{ #category : #'host space - testing' }
BlMockedHostSpace >> needsRebuild [
	"Return true if window should be recreated after user saved and quit pharo"
	
	^ false
]

{ #category : #'host space - displaying' }
BlMockedHostSpace >> open [
	opened := true.
	self show
]

{ #category : #'host space - geometry' }
BlMockedHostSpace >> physicalSize [
	"Return a physical host size which is what the framebuffer size should be.
	This size may differ from the logical size on high dpi (retina) screens.
	In most cases physical size is x2 larger than logical size on retina screens."

	^ physicalSize
]

{ #category : #'window - properties' }
BlMockedHostSpace >> position [
	"Return window's position in screen coordinates"
	<return: #Point>
	
	^ position
]

{ #category : #'window - properties' }
BlMockedHostSpace >> position: aPoint [
	"Change window's position to a given point in screen coordinates"
	
	position := aPoint

]

{ #category : #'host space - drawing' }
BlMockedHostSpace >> render: aSpace [
	"Render a given abstract space on an underlying window or visual area"

	renderCount := renderCount + 1.
	aSpace clearDirtyElements
]

{ #category : #'host space - accessing' }
BlMockedHostSpace >> renderCount [
	"Return how many times my render: method was excecuted"
	<return: #Number>

	^ renderCount
]

{ #category : #'host space - displaying' }
BlMockedHostSpace >> show [
	visible := true
]

{ #category : #'window - properties' }
BlMockedHostSpace >> title [
	"Return window's title as a string"
	<return: #String>

	^ title
]

{ #category : #'window - properties' }
BlMockedHostSpace >> title: aString [
	"Change window's title"

	title := aString
]

{ #category : #'host space - geometry' }
BlMockedHostSpace >> windowExtent: anExtent [
	logicalSize := anExtent asLogicalSize
]
