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
	^ self new matrix: aBlMatrix
]

{ #category : 'computation' }
BlElementAbsoluteTransformation >> computeMatrix: aBlMatrix in: aRectangle [
	aBlMatrix multiplyBy: self matrix
]

{ #category : 'initialization' }
BlElementAbsoluteTransformation >> initialize [
	super initialize.
	
	matrix := BlMatrix2D new
]

{ #category : 'testing' }
BlElementAbsoluteTransformation >> is2D [
	"Return true if my current transformation is in 2D space, false otherwise"
	<return: #Boolean>

	^ self matrix is2D
]

{ #category : 'testing' }
BlElementAbsoluteTransformation >> is3D [
	"Return true if my current transformation is in 3D space, false otherwise"
	<return: #Boolean>

	^ self matrix is3D
]

{ #category : 'testing' }
BlElementAbsoluteTransformation >> isIdentity [
	"Return true if I represent an identity transformation, false otherwise"
	<return: #Boolean>
	
	^ self matrix isIdentity
]

{ #category : 'testing' }
BlElementAbsoluteTransformation >> isPureTranslation [
	"Return true if the receiver specifies no rotation or scaling and represents only translation in xy 2D plane"
	<return: #Boolean>
	
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
