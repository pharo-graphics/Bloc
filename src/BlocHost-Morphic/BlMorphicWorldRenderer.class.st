"
I know how to render the world in a Bloc element
"
Class {
	#name : #BlMorphicWorldRenderer,
	#superclass : #AbstractWorldRenderer,
	#instVars : [
		'element',
		'display',
		'spartaCanvas'
	],
	#category : #'BlocHost-Morphic-World'
}

{ #category : #accessing }
BlMorphicWorldRenderer class >> isApplicableFor: aWorld [
	^ aWorld isKindOf: BlMorphicWorldMorph
]

{ #category : #accessing }
BlMorphicWorldRenderer class >> priority [ 

	^ 3
]

{ #category : #operations }
BlMorphicWorldRenderer >> activateCursor: aCursor withMask: maskForm [
]

{ #category : #activation }
BlMorphicWorldRenderer >> actualScreenSize [
	<return: #Point>

	^ self element extent
]

{ #category : #accessing }
BlMorphicWorldRenderer >> canvas [
	^ display getCanvas
]

{ #category : #accessing }
BlMorphicWorldRenderer >> canvas: aCanvas [
]

{ #category : #activation }
BlMorphicWorldRenderer >> deactivate [
]

{ #category : #activation }
BlMorphicWorldRenderer >> doActivate [
	| initialExtent |
	
	initialExtent := world worldState realWindowExtent ifNil: [976@665].
	
	display := Form extent: initialExtent depth: 32.
	world extent: initialExtent.

	world worldState doFullRepaint.
	world displayWorld
]

{ #category : #accessing }
BlMorphicWorldRenderer >> element [
	^ element
]

{ #category : #accessing }
BlMorphicWorldRenderer >> element: anObject [
	element := anObject
]

{ #category : #accessing }
BlMorphicWorldRenderer >> icon: aForm [
]

{ #category : #activation }
BlMorphicWorldRenderer >> initialize [
	super initialize.
	
	element := BlElement new
]
