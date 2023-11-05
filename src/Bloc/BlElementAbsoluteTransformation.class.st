"
I represent an absolute transformation defined only by transformation matrix

"
Class {
	#name : 'BlElementAbsoluteTransformation',
	#superclass : 'BlElementTransformation',
	#instVars : [
		'matrix'
	],
	#category : 'Bloc-Basic-Transformations'
}

{ #category : 'accessing' }
BlElementAbsoluteTransformation class >> matrix: aBlMatrix [

	^ self basicNew
		initializeWithMatrix: aBlMatrix;
		yourself
]

{ #category : 'computation' }
BlElementAbsoluteTransformation >> computeMatrix: aBlMatrix in: aRectangle [

	aBlMatrix multiplyBy: matrix
]

{ #category : 'initialization' }
BlElementAbsoluteTransformation >> initializeWithMatrix: aBlMatrix [

	self initialize.
	
	matrix := aBlMatrix
]

{ #category : 'testing' }
BlElementAbsoluteTransformation >> is2D [
	"Return true if my current transformation is in 2D space, false otherwise"

	^ matrix is2D
]

{ #category : 'testing' }
BlElementAbsoluteTransformation >> is3D [
	"Return true if my current transformation is in 3D space, false otherwise"

	^ matrix is3D
]

{ #category : 'testing' }
BlElementAbsoluteTransformation >> isIdentity [
	"Return true if I represent an identity transformation, false otherwise"
	
	^ matrix isIdentity
]

{ #category : 'testing' }
BlElementAbsoluteTransformation >> isPureTranslation [
	"Return true if the receiver specifies no rotation or scaling and represents only translation in xy 2D plane"
	
	^ false
]

{ #category : 'accessing' }
BlElementAbsoluteTransformation >> matrix [

	^ matrix
]

{ #category : 'accessing' }
BlElementAbsoluteTransformation >> matrix: aBlMatrix [

	matrix := aBlMatrix
]
