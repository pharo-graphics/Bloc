"
I am a host space created by BlMorphicHost.
I make it possible to embed Bloc space within arbitrary morphs.
For more information and example, please refer to BlMorphicHost.
"
Class {
	#name : #BlMorphicHostSpace,
	#superclass : #BlAbstractMorphicHostSpace,
	#instVars : [
		'spaceHostMorph'
	],
	#category : #'BlocHost-Morphic-Embedded'
}

{ #category : #'window - properties' }
BlMorphicHostSpace >> borderless: aBoolean [
	"Make host window borderless if true is given"
]

{ #category : #'host space - displaying' }
BlMorphicHostSpace >> close [

	self host containerMorph removeMorph: spaceHostMorph
]

{ #category : #'host space - cursor' }
BlMorphicHostSpace >> cursor: aCursor [
	"Change current cursor image/view to the given one"

	self currentHand showTemporaryCursor: aCursor
]

{ #category : #'host space - geometry' }
BlMorphicHostSpace >> densityDpi [
	"Return the screen density expressed as dots-per-inch (a float)"
	
	^ 96.0
]

{ #category : #'window - properties' }
BlMorphicHostSpace >> fullsize: aBoolean [
	"Switch underlying window to fullsize if true is given
	and exit fullsize mode if false is given.
	See ${method:TBlSpaceProperties>>#fullsize}"
]

{ #category : #'host space - events' }
BlMorphicHostSpace >> generateEvents [
	"Generate more complex state change events such as window scale event when resolution of the screen changes"
	
	spaceHostMorph world ifNil: [ spaceHostMorph announceDeleted ]
]

{ #category : #'window - properties' }
BlMorphicHostSpace >> isBorderless [
	"Return true if underlying window is now borderless, false otherwise"
	
	^ false
]

{ #category : #'window - properties' }
BlMorphicHostSpace >> isFullsize [
	"Return true if an underlying window is in fullsize mode, false otherwise.
	Fullsize means that the content of a window is rendered underneath the title bar, which is transparent and has no window title"

	^ true
]

{ #category : #testing }
BlMorphicHostSpace >> isValid [

	^ spaceHostMorph isNotNil
]

{ #category : #'host space - testing' }
BlMorphicHostSpace >> isVisible [
	"Return true if underlying window is shown, false otherwise.
	Note: If window was shown and then minimized it is still considered to be visible.
	Window can become invisible by asking it to hide"

	^ spaceHostMorph visible
]

{ #category : #'host space - geometry' }
BlMorphicHostSpace >> logicalSize [
	"Returns the logical size of the host's client area.
	The client area is the content of the window, excluding the title bar and borders.
	Converting the returned LogicalSize to PhysicalSize produces the size your framebuffer should be."

	^ spaceHostMorph extent asLogicalSize
]

{ #category : #'host space - testing' }
BlMorphicHostSpace >> needsRebuild [
	"Return true if window should be recreated after user saved and quit pharo"

	^ false
]

{ #category : #'host space - geometry' }
BlMorphicHostSpace >> physicalSize [
	"Return a physical host size which is what the framebuffer size should be.
	This size may differ from the logical size on high dpi (retina) screens.
	In most cases physical size is x2 larger than logical size on retina screens."

	| canvasScaleFactor |

	canvasScaleFactor := SystemVersion current major >= 12
		ifTrue: [ (Smalltalk at: #OSWorldRenderer) canvasScaleFactor ]
		ifFalse: [ 1 ].
	^ ((spaceHostMorph width @ spaceHostMorph height) * canvasScaleFactor) asPhysicalSize
]

{ #category : #'window - properties' }
BlMorphicHostSpace >> position [
	"Return window's position in screen coordinates (`Point`)"
	
	^ spaceHostMorph position
]

{ #category : #'window - properties' }
BlMorphicHostSpace >> position: aPoint [
	"Change window's position to a given point in screen coordinates"
	
	spaceHostMorph position: aPoint

]

{ #category : #'host space - rendering' }
BlMorphicHostSpace >> requestRedraw [
	"Space needs to redraw the window"
	
	spaceHostMorph changed
]

{ #category : #'host space - displaying' }
BlMorphicHostSpace >> show [

	spaceHostMorph position: self host containerMorph position.
	self host containerMorph addMorphBack: spaceHostMorph
]

{ #category : #accessing }
BlMorphicHostSpace >> spaceHostMorph [

	^ spaceHostMorph
]

{ #category : #accessing }
BlMorphicHostSpace >> spaceHostMorph: aBlMorphicSpaceHostMorph [

	spaceHostMorph := aBlMorphicSpaceHostMorph.
	spaceHostMorph hostSpace: self
]

{ #category : #'window - properties' }
BlMorphicHostSpace >> title [
	"Return window's title as a string"

	^ ''
]

{ #category : #'window - properties' }
BlMorphicHostSpace >> title: aString [
	"Change window's title"
]

{ #category : #'host space - geometry' }
BlMorphicHostSpace >> windowExtent: anExtent [

	spaceHostMorph extent: anExtent
]
