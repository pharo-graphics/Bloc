"
I represent a matrix decomposition in components.

For example in case of 2D matrix they are:
	- translation
	- scale
	- rotation angle
	- top left 2x2 minor of original matrix
	
3D (4x4) matrices are decomposed as follows:
	- translation
	- scale
	- skew
	- perspective
	- quaternion

"
Class {
	#name : #BlMatrixDecomposition,
	#superclass : #Object,
	#category : #'Bloc-Basic-Math'
}

{ #category : #'matrix - mathematical functions' }
BlMatrixDecomposition >> composition [
	"Compose and return a `BlMatrix` for this decomposition"
	
	^ self subclassResponsibility
]

{ #category : #'matrix - mathematical functions' }
BlMatrixDecomposition >> interpolate: aFactor to: anotherDecomposition [
	"Answer a `BlMatrixDecomposition` that interpolates self with anotherDecomposition."

	^ self subclassResponsibility
]
