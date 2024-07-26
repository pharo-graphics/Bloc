"
I am a composite transformation that consists of other element transformations, either absolute, local or composite

"
Class {
	#name : #BlElementCompositeTransformation,
	#superclass : #BlElementDynamicTransformation,
	#instVars : [
		'elementTransformations'
	],
	#category : #'Bloc-Basic-Transformations'
}

{ #category : #adding }
BlElementCompositeTransformation >> add: aBlElementTransformation [

	elementTransformations add: aBlElementTransformation
]

{ #category : #enumerating }
BlElementCompositeTransformation >> affineTransformationsDo: aBlockClosure [ 

	elementTransformations do: [ :each |
		each affineTransformationsDo: aBlockClosure ]
]

{ #category : #computation }
BlElementCompositeTransformation >> computeMatrix: aBlMatrix in: aRectangle [

	elementTransformations reverseDo: [ :each |
		each computeMatrix: aBlMatrix in: aRectangle ]

	"Note: when composing transformations we should perform left multiplication.
		since multiplyBy: is a right multiplication we should iterate in reversed order"
]

{ #category : #accessing }
BlElementCompositeTransformation >> elementTransformations [

	^ elementTransformations
]

{ #category : #initialization }
BlElementCompositeTransformation >> initialize [
	super initialize.
	
	elementTransformations := OrderedCollection new
]

{ #category : #testing }
BlElementCompositeTransformation >> is2D [
	"Return true if my current transformation is in 2D space, false otherwise"

	^ elementTransformations allSatisfy: [ :each | each is2D ]
]

{ #category : #testing }
BlElementCompositeTransformation >> is3D [

	^ elementTransformations anySatisfy: [ :each | each is3D ]
]

{ #category : #testing }
BlElementCompositeTransformation >> isIdentity [
	"Return true if I represent an identity transformation, false otherwise"

	^ elementTransformations allSatisfy: [ :each | each isIdentity ]
]

{ #category : #testing }
BlElementCompositeTransformation >> isPureTranslation [
	"Return true if I represent an pure translation, false otherwise"

	^ elementTransformations allSatisfy: [ :each | each isPureTranslation ]
]
