"
I am a composite transformation that consists of other element transformations, either absolute, local or composite

"
Class {
	#name : #BlElementCompositeTransformation,
	#superclass : #BlElementDynamicTransformation,
	#instVars : [
		'transformations'
	],
	#category : #'Bloc-Basic-Transformations'
}

{ #category : #adding }
BlElementCompositeTransformation >> add: anElementTransformation [
	self transformations add: anElementTransformation
]

{ #category : #computation }
BlElementCompositeTransformation >> computeMatrix: aBlMatrix in: aRectangle [
	self transformations
		"when composing transformations we should perform left multiplication.
		since multiplyBy: is a right multiplication we should iterate in reversed order"
		reverseDo: [ :anElementTransformation | anElementTransformation computeMatrix: aBlMatrix in: aRectangle ]
]

{ #category : #initialization }
BlElementCompositeTransformation >> initialize [
	super initialize.
	
	transformations := OrderedCollection new
]

{ #category : #testing }
BlElementCompositeTransformation >> is2D [
	"Return true if my current transformation is in 2D space, false otherwise"
	<return: #Boolean>
	
	^ self transformations allSatisfy: #is2D
]

{ #category : #testing }
BlElementCompositeTransformation >> is3D [
	<return: #Boolean>
	
	^ self transformations anySatisfy: #is3D
]

{ #category : #testing }
BlElementCompositeTransformation >> isIdentity [
	"Return true if I represent an identity transformation, false otherwise"
	<return: #Boolean>

	^ self transformations allSatisfy: #isIdentity
]

{ #category : #testing }
BlElementCompositeTransformation >> isPureTranslation [
	"Return true if I represent an pure translation, false otherwise"
	<return: #Boolean>

	^ self transformations allSatisfy: #isPureTranslation
]

{ #category : #accessing }
BlElementCompositeTransformation >> transformations [
	<return: #Collection of: #BlElementTransformation>

	^ transformations
]
