"
I am an affine transformation that is directly defined by transformation matrix
"
Class {
	#name : #BlMatrixTransformation,
	#superclass : #BlAffineTransformation,
	#instVars : [
		'matrix'
	],
	#category : 'Bloc-Basic-Transformations'
}

{ #category : #'instance creation' }
BlMatrixTransformation class >> matrix: aBlMatrix [
	^ self new matrix: aBlMatrix
]

{ #category : #initialization }
BlMatrixTransformation >> initialize [
	super initialize.
	
	matrix := BlMatrix2D new
]

{ #category : #testing }
BlMatrixTransformation >> is2D [
	^ self matrix is2D
]

{ #category : #accessing }
BlMatrixTransformation >> matrix [
	<return: #BlMatrix>

	^ matrix
]

{ #category : #accessing }
BlMatrixTransformation >> matrix: aBlMatrix [
	matrix := aBlMatrix
]

{ #category : #'mathematical functions' }
BlMatrixTransformation >> multiplyOn: aBlMatrix [
	aBlMatrix multiplyBy: self matrix
]
