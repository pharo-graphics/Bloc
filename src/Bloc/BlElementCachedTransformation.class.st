"
I define a cached element's transformation.

A cached transformation is defined as a tuple `(transformation, matrix)`, where 
- `transformation` is a composite element independent definition of a transformation and
- `matrix` is a concrete computed transformation `BlMatrix` which may depend on element's bounds.

Hence the separation between my subclasses.

"
Class {
	#name : #BlElementCachedTransformation,
	#superclass : #Object,
	#category : #'Bloc-Basic-Transformations'
}

{ #category : #'api - converting' }
BlElementCachedTransformation >> asCachedTransformationIn: aRectangle [

	^ self
		  boundingRectangle: aRectangle;
		  yourself
]

{ #category : #'api - converting' }
BlElementCachedTransformation >> asElementTransformation [

	^ self subclassResponsibility
]

{ #category : #'api - transformation' }
BlElementCachedTransformation >> boundingRectangle: aRectangle [
	"The actual transformation matrix may depend on the element bounds due to potential non-zero transformation origin.
	This message allows cached transformation to recompute the transformation matrix when bounds change."

	self subclassResponsibility
]

{ #category : #'api - transformation' }
BlElementCachedTransformation >> inverseTransformBounds: aBlBounds [
	"Transform the given bounds according to inverse of my cached transformation.
	(Global to local transformation.)"
	
	^ self subclassResponsibility
]

{ #category : #'api - transformation' }
BlElementCachedTransformation >> inverseTransformPoint: aPoint [
	"Answer the point that results from applying my inverted transformation to a given point.
	May signal `BlSingularMatrixError` if the underlying matrix is singular."
	
	^ self subclassResponsibility
]

{ #category : #'api - testing' }
BlElementCachedTransformation >> isIdentity [

	^ self subclassResponsibility
]

{ #category : #'api - transformation' }
BlElementCachedTransformation >> matrix [
	
	^ self subclassResponsibility
]

{ #category : #'api - transformation' }
BlElementCachedTransformation >> transformBounds: aBlBounds [
	"Transform the given bounds according to my cached transformation.
	(Local to global transformation.)"
	
	^ self subclassResponsibility
]

{ #category : #'api - transformation' }
BlElementCachedTransformation >> transformPoint: aPoint [
	"Transform a given 2D point according to my cached transformation.
	(Local to global transformation.)"
	
	^ self subclassResponsibility
]
