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
	
	anElementTransformation owner: self owner.
	self transformations add: anElementTransformation
]

{ #category : #computation }
BlElementCompositeTransformation >> computeMatrix [	
	self transformations
		"when composing transformations we should perform left multiplication.
		since multiplyBy: is a right multiplication we should iterate in reversed order"
		reverseDo: [ :anElementTransformation | matrix multiplyBy: anElementTransformation matrix ]
]

{ #category : #initialization }
BlElementCompositeTransformation >> initialize [
	super initialize.
	
	transformations := OrderedCollection new
]

{ #category : #invalidation }
BlElementCompositeTransformation >> invalidateMatrix [
	"Matrix is computed out of affine transformation composition
	which may contain transformations that depend on element's properties
	such as extent. It means that when element changes we need to invalidate and
	recompute the matrix => set it to nil to trigger computation on next matrix access"

	matrix := nil.
	self transformations do: #invalidateMatrix
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
BlElementCompositeTransformation >> matrix [
	<return: #BlMatrix>

	self ensureMatrix.
	^ matrix
]

{ #category : #accessing }
BlElementCompositeTransformation >> owner: anElement [
	super owner: anElement.
	self transformations do: [ :aTransformation | aTransformation owner: anElement ]
]

{ #category : #accessing }
BlElementCompositeTransformation >> transformations [
	<return: #Collection of: #BlElementTransformation>

	^ transformations
]
