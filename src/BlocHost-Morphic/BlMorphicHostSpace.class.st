"
I am a host space created by BlMorphicHost.
I make it possible to embed Bloc space within arbitrary morphs.
For more information and example, please refer to BlMorphicHost.
"
Class {
	#name : #BlMorphicHostSpace,
	#superclass : #Object,
	#traits : 'TBlHostSpace',
	#classTraits : 'TBlHostSpace classTrait',
	#instVars : [
		'spaceHostMorph'
	],
	#category : #'BlocHost-Morphic-Host - Morph'
}

{ #category : #'window - properties' }
BlMorphicHostSpace >> borderless [
	"Return true if underlying window is now borderless, false otherwise"
	<return: #Boolean>
	
	^ false
]

{ #category : #'window - properties' }
BlMorphicHostSpace >> borderless: aBoolean [
	"Make host window borderless if true is given"
]

{ #category : #'host space - accessing' }
BlMorphicHostSpace >> canvasExtent [
	"Return a window canvas size in user coordinates.
	This size may differ from the window size on high dpi (retina) screens.
	In most cases canvas is x2 larger than window in pixel on retina screens."
	<return: #Point>

	^ self windowExtent
]

{ #category : #'host space - displaying' }
BlMorphicHostSpace >> close [
	self host containerMorph removeMorph: self spaceHostMorph
]

{ #category : #'host space - cursor' }
BlMorphicHostSpace >> cursor: aCursor [
	"Change current cursor image/view to the given one"
	World currentHand showTemporaryCursor: aCursor asForm
]

{ #category : #'host space - accessing' }
BlMorphicHostSpace >> densityDpi [
	"Return the screen density expressed as dots-per-inch"
	<return: #Number>
	
	^ 96.0
]

{ #category : #'host space - events' }
BlMorphicHostSpace >> generateEvents [
	"Generate more complex state change events such as window scale event when resolution of the screen changes"
	
	spaceHostMorph world ifNil: [ spaceHostMorph announceDeleted ]
]

{ #category : #initialization }
BlMorphicHostSpace >> initialize [
	super initialize
]

{ #category : #'host space - testing' }
BlMorphicHostSpace >> needsRebuild [
	"Return true if window should be recreated after user saved and quit pharo"
	<return: #Boolean>

	^ false
]

{ #category : #'window - properties' }
BlMorphicHostSpace >> position [
	"Return window's position in screen coordinates"
	<return: #Point>
	
	^ self spaceHostMorph position
]

{ #category : #'window - properties' }
BlMorphicHostSpace >> position: aPoint [
	"Change window's position to a given point in screen coordinates"
	
	self spaceHostMorph position: aPoint

]

{ #category : #'host space - rendering' }
BlMorphicHostSpace >> presentFormSurface: aBlHostRendererFormSurface areas: aCollectionOfAreas [
	spaceHostMorph form: aBlHostRendererFormSurface form
]

{ #category : #'host space - rendering' }
BlMorphicHostSpace >> requestRedraw [
	"Space needs to redraw the window"
	
	spaceHostMorph changed
]

{ #category : #'host space - displaying' }
BlMorphicHostSpace >> show [
	self spaceHostMorph position: self host containerMorph position.
	self host containerMorph addMorphBack: self spaceHostMorph
]

{ #category : #accessing }
BlMorphicHostSpace >> spaceHostMorph [
	<return: #BlMorphicSpaceHostMorph>

	^ spaceHostMorph
]

{ #category : #accessing }
BlMorphicHostSpace >> spaceHostMorph: aMorphicSpaceHostMorph [
	spaceHostMorph := aMorphicSpaceHostMorph.
	aMorphicSpaceHostMorph hostSpace: self
]

{ #category : #'window - properties' }
BlMorphicHostSpace >> title [
	"Return window's title as a string"
	<return: #String>

	^ ''
]

{ #category : #'window - properties' }
BlMorphicHostSpace >> title: aString [
	"Change window's title"
]

{ #category : #'host space - accessing' }
BlMorphicHostSpace >> windowExtent [
	"Return the window size in screen coordinates.
	This size may differ from the size in pixels of underlying surface 
	on high dpi (retina) screens"
	<return: #Point>

	^ spaceHostMorph extent
]

{ #category : #'host space - accessing' }
BlMorphicHostSpace >> windowExtent: anExtent [
	spaceHostMorph extent: anExtent
]
