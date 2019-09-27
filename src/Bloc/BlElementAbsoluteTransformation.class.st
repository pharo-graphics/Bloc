"
I represent an absolute transformation defined only by transformation matrix
"
Class {
	#name : #BlElementAbsoluteTransformation,
	#superclass : #BlElementTransformation,
	#category : #'Bloc-Basic-Transformations'
}

{ #category : #accessing }
BlElementAbsoluteTransformation class >> matrix: aBlMatrix [
	^ self new matrix: aBlMatrix
]

{ #category : #initialization }
BlElementAbsoluteTransformation >> initialize [
	super initialize.
	
	matrix := BlMatrix2D new
]

{ #category : #invalidation }
BlElementAbsoluteTransformation >> invalidateMatrix [
	"Do nothing, since matrix is statically defined"
]

{ #category : #testing }
BlElementAbsoluteTransformation >> is2D [
	"Return true if my current transformation is in 2D space, false otherwise"
	<return: #Boolean>

	^ self matrix is2D
]

{ #category : #testing }
BlElementAbsoluteTransformation >> is3D [
	"Return true if my current transformation is in 3D space, false otherwise"
	<return: #Boolean>

	^ self matrix is3D
]

{ #category : #testing }
BlElementAbsoluteTransformation >> isIdentity [
	"Return true if I represent an identity transformation, false otherwise"
	<return: #Boolean>
	
	^ self matrix isIdentity
]

{ #category : #accessing }
BlElementAbsoluteTransformation >> matrix [
	^ matrix
]

{ #category : #accessing }
BlElementAbsoluteTransformation >> matrix: aBlMatrix [
	matrix := aBlMatrix
]
