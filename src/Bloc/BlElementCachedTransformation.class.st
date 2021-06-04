"
# Abstract cached element's transformation
I define an API of the cached element's transformation.

A cached transformation is defined as a tuple `(transformation, matrix)`, where `transformation` is a composite element independent  definition of a transformation and `matrix` is a concrete computed transformation {{gtClass:BlMatrix}} which may depend on element's bounds.
Hence the separation between {{gtClass:BlElementTransformation}} and {{gtClass:BlElementCachedTransformation}}

"
Class {
	#name : #BlElementCachedTransformation,
	#superclass : #Object,
	#category : #'Bloc-Basic-Transformations'
}

{ #category : #'api - converting' }
BlElementCachedTransformation >> asCachedTransformation [
	^ self
]

{ #category : #'api - converting' }
BlElementCachedTransformation >> asElementTransformation [
	^ self subclassResponsibility
]

{ #category : #'api - transformation' }
BlElementCachedTransformation >> bounds: aRectangle [
	"The actual transformation matrix may depends on the element bounds due to
	potential non zero transformation origin.
	This allows cached transformation to recompute the transformation matrix when bounds change"

	self subclassResponsibility
]

{ #category : #'api - transformation' }
BlElementCachedTransformation >> inverseTransformBounds: aBounds [
	"In-place transform given BlBounds according to my transformation.
	(global to local transformation)"
	<return: #BlBounds>
	
	^ self subclassResponsibility
]

{ #category : #'api - transformation' }
BlElementCachedTransformation >> inverseTransformPoint: aPoint [
	"Apply an inversed transformation on a given point and return a result.
	Note: Throws BlSingularMatrixError if underlying matrix is singular"
	<return: #Point>
	
	^ self subclassResponsibility
]

{ #category : #'api - testing' }
BlElementCachedTransformation >> isIdentity [
	<return: #Boolean>

	^ self subclassResponsibility
]

{ #category : #'api - transformation' }
BlElementCachedTransformation >> matrix [
	<return: #BlMatrix>
	
	^ self subclassResponsibility
]

{ #category : #'api - transformation' }
BlElementCachedTransformation >> transformBounds: aBounds [
	"In-place transform given BlBounds according to my transformation.
	(local to global transformation)"
	<return: #BlBounds>
	
	^ self subclassResponsibility
]

{ #category : #'api - transformation' }
BlElementCachedTransformation >> transformPoint: aPoint [
	"Transform given 2D point according to my transformation and return a transformed result point.
	(local to global transformation)"
	<return: #Point>
	
	^ self subclassResponsibility
]
