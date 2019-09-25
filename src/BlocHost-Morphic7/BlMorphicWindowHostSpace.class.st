"
I am a concrete implementation of a BlHostSpace.
My responsibility is to control morphic window using unified host space api.

Depends on Bloc-Sparta
"
Class {
	#name : #BlMorphicWindowHostSpace,
	#superclass : #Object,
	#traits : 'TBlHostSpace',
	#classTraits : 'TBlHostSpace classTrait',
	#instVars : [
		'morphicWindow',
		'isFullSize',
		'isBorderless'
	],
	#category : #'BlocHost-Morphic7-Host - Window'
}

{ #category : #'window - properties' }
BlMorphicWindowHostSpace >> borderless [
	"Return true if underlying window is now borderless, false otherwise"
	<return: #Boolean>
	
	^ isBorderless
]

{ #category : #'window - properties' }
BlMorphicWindowHostSpace >> borderless: aBoolean [
	"Make host window borderless if true is given"

	isBorderless := aBoolean.
	morphicWindow borderless: aBoolean
]

{ #category : #'host space - accessing' }
BlMorphicWindowHostSpace >> canvasExtent [
	^ self windowExtent
]

{ #category : #'host space - displaying' }
BlMorphicWindowHostSpace >> close [
	morphicWindow close
]

{ #category : #'host space - cursor' }
BlMorphicWindowHostSpace >> cursor: aCursor [
	"Change current cursor image/view to the given one"
	World currentHand showTemporaryCursor: aCursor asForm
]

{ #category : #'host space - accessing' }
BlMorphicWindowHostSpace >> densityDpi [
	"Return the screen density expressed as dots-per-inch"
	<return: #Number>
	
	^ 96.0
]

{ #category : #'window - properties' }
BlMorphicWindowHostSpace >> fullsize [
	"Return true if an underlying window is in fullsize mode,
	false otherwise.
	Fullsize means that the content of a window is rendered underneath the title bar, which is transparent
	and has no window title"
	<return: #Boolean>

	^ isFullSize
]

{ #category : #'window - properties' }
BlMorphicWindowHostSpace >> fullsize: aBoolean [
	"Switch underlying window to fullsize if true is given
	and exit fullsize mode if false is given.
	See ${method:TBlSpaceProperties>>#fullsize}"

	isFullSize := aBoolean.
	morphicWindow fullsize: aBoolean.
]

{ #category : #initialization }
BlMorphicWindowHostSpace >> initialize [
	super initialize.
	
	isBorderless := false.
	isFullSize := false
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
	<return: #Boolean>

	^ false
]

{ #category : #'window - properties' }
BlMorphicWindowHostSpace >> position [
	"Return window's position in screen coordinates"
	<return: #Point>
	
	^ morphicWindow position
]

{ #category : #'window - properties' }
BlMorphicWindowHostSpace >> position: aPoint [
	"Change window's position to a given point in screen corrdinates"
	
	morphicWindow position: aPoint
]

{ #category : #'host space - rendering' }
BlMorphicWindowHostSpace >> presentFormSurface: aBlHostRendererFormSurface areas: aCollectionOfAreas [
	morphicWindow form: aBlHostRendererFormSurface form
]

{ #category : #'host space - displaying' }
BlMorphicWindowHostSpace >> show [
	| anExtent |
	
	anExtent := morphicWindow extent.
	morphicWindow openInWorld.
	morphicWindow extent: anExtent
]

{ #category : #'window - properties' }
BlMorphicWindowHostSpace >> title [
	"Return window's title as a string"
	<return: #String>

	^ morphicWindow title
]

{ #category : #'window - properties' }
BlMorphicWindowHostSpace >> title: aString [
	"Change window's title"

	morphicWindow title: aString
]

{ #category : #'host space - accessing' }
BlMorphicWindowHostSpace >> windowExtent [
	"Return the window size in screen coordinates.
	This size may differ from the size in pixels of underlying surface 
	on high dpi (retina) screens"
	<return: #Point>

	^ morphicWindow spaceExtent
]

{ #category : #'host space - accessing' }
BlMorphicWindowHostSpace >> windowExtent: anExtent [
	morphicWindow spaceExtent: anExtent
]
