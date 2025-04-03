"
I am a Bloc host space to control Morphic window.

"
Class {
	#name : #BlMorphicWindowHostSpace,
	#superclass : #Object,
	#traits : 'TBlHostSpace + TBlSpaceProperties',
	#classTraits : 'TBlHostSpace classTrait + TBlSpaceProperties classTrait',
	#instVars : [
		'morphicWindow',
		'isFullSize',
		'isBorderless'
	],
	#category : #'BlocHost-Morphic-Window'
}

{ #category : #'window - properties' }
BlMorphicWindowHostSpace >> borderless: aBoolean [
	"Make host window borderless if true is given"

	isBorderless := aBoolean.
	morphicWindow borderless: aBoolean
]

{ #category : #'window - properties' }
BlMorphicWindowHostSpace >> center [

	morphicWindow center
]

{ #category : #'host space - displaying' }
BlMorphicWindowHostSpace >> close [

	morphicWindow close
]

{ #category : #'host space - cursor' }
BlMorphicWindowHostSpace >> cursor: aCursor [
	"Change current cursor image/view to the given one"

	self currentHand showTemporaryCursor: aCursor
]

{ #category : #'host space - geometry' }
BlMorphicWindowHostSpace >> densityDpi [
	"Return the screen density expressed as dots-per-inch (a float)"
	
	^ 96.0
]

{ #category : #'window - properties' }
BlMorphicWindowHostSpace >> fullscreen: aBoolean [
	"Ignore. A Morphic space can't be fullscreen."

]

{ #category : #'window - properties' }
BlMorphicWindowHostSpace >> fullsize: aBoolean [
	"Switch underlying window to fullsize if true is given
	and exit fullsize mode if false is given.
	See ${method:TBlSpaceProperties>>#fullsize}"

	isFullSize := aBoolean.
	morphicWindow fullsize: aBoolean
]

{ #category : #'host space - displaying' }
BlMorphicWindowHostSpace >> hide [
	
	morphicWindow visible: false.
]

{ #category : #initialization }
BlMorphicWindowHostSpace >> initialize [

	super initialize.
	
	isBorderless := false.
	isFullSize := false
]

{ #category : #'dirty areas' }
BlMorphicWindowHostSpace >> invalidate [
	
	morphicWindow := nil
]

{ #category : #'window - properties' }
BlMorphicWindowHostSpace >> isBorderless [
	"Return true if underlying window is now borderless, false otherwise"
	
	^ isBorderless
]

{ #category : #'window - properties' }
BlMorphicWindowHostSpace >> isFullscreen [
	"Return false, as a Morphic space doesn't support fullscreen."

	^ false
]

{ #category : #'window - properties' }
BlMorphicWindowHostSpace >> isFullsize [
	"Return true if an underlying window is in fullsize mode, false otherwise.
	Fullsize means that the content of a window is rendered underneath the title bar, which is transparent and has no window title"

	^ isFullSize
]

{ #category : #'window - properties' }
BlMorphicWindowHostSpace >> isResizable [
	"Return true if underlying window is resizable, false otherwise"

	^ morphicWindow isResizeable
]

{ #category : #'text input' }
BlMorphicWindowHostSpace >> isTextInputActive [
	"Check whether or not Unicode text input events are enabled"
	^ morphicWindow isTextInputActive
]

{ #category : #testing }
BlMorphicWindowHostSpace >> isValid [
	
	^ morphicWindow isNotNil
]

{ #category : #testing }
BlMorphicWindowHostSpace >> isVisible [

	^ morphicWindow visible
]

{ #category : #'host space - geometry' }
BlMorphicWindowHostSpace >> logicalSize [
	"Returns the logical size of the host's client area.
	The client area is the content of the window, excluding the title bar and borders.
	Converting the returned LogicalSize to PhysicalSize produces the size your framebuffer should be."

	^ morphicWindow spaceExtent asLogicalSize
]

{ #category : #'host space - displaying' }
BlMorphicWindowHostSpace >> maximize [

	morphicWindow maximize
]

{ #category : #'host space - displaying' }
BlMorphicWindowHostSpace >> maximized [

	^ morphicWindow isMaximized
]

{ #category : #'host space - displaying' }
BlMorphicWindowHostSpace >> minimize [

	morphicWindow minimize
]

{ #category : #'host space - displaying' }
BlMorphicWindowHostSpace >> minimized [

	^ morphicWindow isMinimized
]

{ #category : #'private - accessing' }
BlMorphicWindowHostSpace >> morphicWindow [
	^ morphicWindow
]

{ #category : #'private - accessing' }
BlMorphicWindowHostSpace >> morphicWindow: aWindow [
	morphicWindow := aWindow.
	morphicWindow hostSpace: self
]

{ #category : #'host space - testing' }
BlMorphicWindowHostSpace >> needsRebuild [
	"Return true if window should be recreated after user saved and quit pharo"

	^ false
]

{ #category : #initialization }
BlMorphicWindowHostSpace >> newSurfaceRenderer [

	^ BlMorphicFormSurfaceRenderer new
		spaceHostMorph: morphicWindow spaceHostMorph;
		yourself
]

{ #category : #'host space - geometry' }
BlMorphicWindowHostSpace >> physicalSize [
	"Return a physical host size which is what the framebuffer size should be.
	This size may differ from the logical size on high dpi (retina) screens.
	In most cases physical size is x2 larger than logical size on retina screens."

	| canvasScaleFactor |

	canvasScaleFactor := SystemVersion current major >= 12
		ifTrue: [ (Smalltalk at: #OSWorldRenderer) canvasScaleFactor ]
		ifFalse: [ 1 ].
	^ ((morphicWindow spaceExtent x @ morphicWindow spaceExtent y) * canvasScaleFactor) asPhysicalSize
]

{ #category : #'window - properties' }
BlMorphicWindowHostSpace >> position [
	"Return window's position in screen coordinates"
	
	^ morphicWindow position
]

{ #category : #'window - properties' }
BlMorphicWindowHostSpace >> position: aPoint [
	"Change window's position to a given point in screen corrdinates"
	
	morphicWindow position: aPoint
]

{ #category : #'window - properties' }
BlMorphicWindowHostSpace >> resizable: aBoolean [
	"Make underlying window resizable if true is given"
	
	morphicWindow isResizeable: aBoolean
]

{ #category : #'host space - displaying' }
BlMorphicWindowHostSpace >> show [

	| anExtent |
	morphicWindow visible: true.
	
	anExtent := morphicWindow extent.
	morphicWindow openInWorld.
	morphicWindow extent: anExtent
]

{ #category : #'text input' }
BlMorphicWindowHostSpace >> startTextInput [
	"Start accepting Unicode text input events.
	I will start accepting Unicode text input events in the focused window, and start emitting text input and text editing events.
	Please use me in pair with stopTextInput.
	On some platforms I may activate the screen keyboard."

	morphicWindow startTextInput
]

{ #category : #'text input' }
BlMorphicWindowHostSpace >> startTextInputAtRectangle: aRectangle [
	"Start accepting Unicode text input events.
	I will start accepting Unicode text input events in the focused window, and start emitting text input and text editing events.
	Please use me in pair with stopTextInput.
	On some platforms I may activate the screen keyboard."

	morphicWindow requestTextEditingAt: aRectangle
]

{ #category : #'text input' }
BlMorphicWindowHostSpace >> stopTextInput [
	"Stop receiving any text input events"

	morphicWindow requestStopTextEditing
]

{ #category : #'window - properties' }
BlMorphicWindowHostSpace >> title [
	"Return window's title as a string"

	^ morphicWindow title
]

{ #category : #'window - properties' }
BlMorphicWindowHostSpace >> title: aString [
	"Change window's title"

	morphicWindow title: aString
]

{ #category : #'host space - geometry' }
BlMorphicWindowHostSpace >> windowExtent: anExtent [

	morphicWindow spaceExtent: anExtent
]
