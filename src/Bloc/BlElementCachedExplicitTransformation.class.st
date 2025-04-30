"
I cache a `BlElementTransformation`.

"
Class {
	#name : #BlElementCachedExplicitTransformation,
	#superclass : #BlElementCachedTransformation,
	#instVars : [
		'matrix',
		'elementTransformation',
		'boundingRectangle'
	],
	#category : #'Bloc-Basic-Transformations'
}

{ #category : #'instance creation' }
BlElementCachedExplicitTransformation class >> forTransformation: aBlElementTransformation in: aRectangle [

	^ self basicNew
		initializeWith: aBlElementTransformation;
		boundingRectangle: aRectangle;
		yourself
]

{ #category : #'api - converting' }
BlElementCachedExplicitTransformation >> asElementTransformation [

	^ elementTransformation
]

{ #category : #'private - accessing' }
BlElementCachedExplicitTransformation >> boundingRectangle [

	^ boundingRectangle
]

{ #category : #'api - transformation' }
BlElementCachedExplicitTransformation >> boundingRectangle: aRectangle [

	boundingRectangle := aRectangle.
	self invalidateMatrix
]

{ #category : #'private - accessing' }
BlElementCachedExplicitTransformation >> elementTransformation [

	^ elementTransformation
]

{ #category : #'private - accessing' }
BlElementCachedExplicitTransformation >> ensureMatrix [

	matrix ifNil: [
		matrix := elementTransformation asMatrix: boundingRectangle ]
]

{ #category : #initialization }
BlElementCachedExplicitTransformation >> initializeWith: aBlElementTransformation [

	self initialize.

	elementTransformation := aBlElementTransformation
]

{ #category : #'private - accessing' }
BlElementCachedExplicitTransformation >> invalidateMatrix [
	"Matrix is computed out of affine transformation composition
	which may contain transformations that depend on element's properties
	such as extent. It means that when element changes we need to invalidate and
	recompute the matrix => set it to nil to trigger computation on next matrix access"

	matrix := nil
]

{ #category : #'api - transformation' }
BlElementCachedExplicitTransformation >> inverseTransformBounds: aBlBounds [
	"Transform the given bounds according to inverse of my cached transformation.
	(Global to local transformation.)"

	^ self matrix inverted transformBounds: aBlBounds
]

{ #category : #'api - transformation' }
BlElementCachedExplicitTransformation >> inverseTransformPoint: aPoint [
	"Answer the `Point` that results from applying the inversed transformation on a given point.
	Signal `BlSingularMatrixError` if the underlying matrix is singular."

	^ self matrix inverted transformPoint: aPoint
]

{ #category : #'private - accessing' }
BlElementCachedExplicitTransformation >> invert [

	matrix := self matrix inverted
]

{ #category : #'private - accessing' }
BlElementCachedExplicitTransformation >> inverted [

	^ self copy invert
]

{ #category : #'api - testing' }
BlElementCachedExplicitTransformation >> isIdentity [

	^ elementTransformation isIdentity
]

{ #category : #accessing }
BlElementCachedExplicitTransformation >> isPureTranslation [

	^ elementTransformation isPureTranslation
]

{ #category : #'api - transformation' }
BlElementCachedExplicitTransformation >> matrix [

	self ensureMatrix.
	^ matrix
]

{ #category : #'api - transformation' }
BlElementCachedExplicitTransformation >> transformBounds: aBlBounds [
	"Transform the given bounds according to my cached transformation.
	(Local to global transformation.)"

	self matrix transformBounds: aBlBounds.

	^ aBlBounds 
	
]

{ #category : #'api - transformation' }
BlElementCachedExplicitTransformation >> transformPoint: aPoint [
	"Transform a given 2D point according to my cached transformation.
	(Local to global transformation.)"
	
	^ self matrix transformPoint: aPoint
]
