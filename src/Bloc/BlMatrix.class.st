"
I represent a transformation Matrix and define common API of 2D and 3D matrices

"
Class {
	#name : #BlMatrix,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'Bloc-Basic-Math'
}

{ #category : #comparing }
BlMatrix >> = anObject [

	self subclassResponsibility
]

{ #category : #'matrix - mathematical functions' }
BlMatrix >> decomposition [
	"Return a decomposition of the matrix (`BlMatrixDecomposition`)"
	
	^ self subclassResponsibility
]

{ #category : #'matrix - mathematical functions' }
BlMatrix >> determinant [
	"Compute and return my determinant"
	
	^ self subclassResponsibility
]

{ #category : #comparing }
BlMatrix >> hash [

	^ self subclassResponsibility
]

{ #category : #'matrix - mathematical functions' }
BlMatrix >> interpolate: aFactor to: anotherMatrix [
	"Answer a `BlMatrix` that interpolates self with another matrix, with a given factor."
	
	^ (self decomposition
		interpolate: aFactor
		to: anotherMatrix decomposition) composition
]

{ #category : #testing }
BlMatrix >> is2D [
	"Return true if matrix is 2D, false otherwise"
	
	^ self subclassResponsibility
]

{ #category : #testing }
BlMatrix >> isIdentity [
	
	^ self subclassResponsibility
]

{ #category : #'matrix - transformations' }
BlMatrix >> multiplyBy: aMatrix [
	"Perform a right multiplication by a given matrix"
	
	self subclassResponsibility
]

{ #category : #'matrix - transformations' }
BlMatrix >> perspective: aDepth [
	"Apply perspective by aDepth which should be positive"
	
	self subclassResponsibility
]

{ #category : #'matrix - transformations' }
BlMatrix >> reflectBy: aDiagonalVector [
	"Apply a reflection transformation given by a diagonal vector"
	
	self subclassResponsibility
]

{ #category : #'matrix - transformations' }
BlMatrix >> rotateBy: aNumber [
	"Apply a rotation transformation by a given amount of degrees around z-axis"
	
	self
		rotateByDegrees: aNumber
		around: BlVector zAxis
]

{ #category : #'matrix - transformations' }
BlMatrix >> rotateByDegrees: aNumber around: aBlVector [
	"Apply a rotation transformation by a given amount of degrees around a provided axis vector"
	
	self rotateByRadians: aNumber degreesToRadians around: aBlVector
]

{ #category : #'matrix - transformations' }
BlMatrix >> rotateByRadians: aNumber around: aBlVector [
	"Apply a rotation transformation by a given amount of radians around a provided axis vector"
	
	self subclassResponsibility
]

{ #category : #'matrix - transformations' }
BlMatrix >> scaleBy: aBlVector [
	"Apply a scaling defined by a given vector"
	
	self subclassResponsibility
]

{ #category : #'matrix - transforming points' }
BlMatrix >> transformBounds: aBlBounds [
	"In-place transform given `BlBounds` according to my transformation.
	(local to global transformation)"
	
	^ self subclassResponsibility
]

{ #category : #'matrix - transforming points' }
BlMatrix >> transformPoint2D: aBlPoint2D [
	"Transform a given 2D point (either a ==Point== or ==BlPoint2D==).
	In any case return BlPoint2D"

	^ self subclassResponsibility
]

{ #category : #'matrix - transforming points' }
BlMatrix >> transformPoint3D: aBlPoint3D [
	"Transform a given 3D point according to this transformation matrix"
	
	^ self subclassResponsibility
]

{ #category : #'matrix - transforming points' }
BlMatrix >> transformPoint4D: aBlPoint4D [
	"Transform a given 4D point according to this transformation matrix"
	
	^ self subclassResponsibility
]

{ #category : #'matrix - transforming points' }
BlMatrix >> transformPoint: aPoint [
	"Return a `BlPoint` that is the transformation of a given point according
	to transformation matrix.
	I perform a double dispatch to handle 2D/3D/4D points and 2D/3D matrices."

	^ aPoint transformedOn: self
]

{ #category : #'matrix - transformations' }
BlMatrix >> translateBy: aBlVector [
	"Apply a translation by a given vector"
	
	self subclassResponsibility
]
