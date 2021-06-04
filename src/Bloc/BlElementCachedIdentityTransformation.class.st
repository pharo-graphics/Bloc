"
# Cached identity transformation
Represents an identity transformation with a unique instance cached identity matrix

"
Class {
	#name : #BlElementCachedIdentityTransformation,
	#superclass : #BlElementCachedTransformation,
	#classVars : [
		'IdentityMatrix'
	],
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Bloc-Basic-Transformations'
}

{ #category : #cleanup }
BlElementCachedIdentityTransformation class >> cleanUp [
	uniqueInstance := nil
]

{ #category : #'class initialization' }
BlElementCachedIdentityTransformation class >> initialize [
	IdentityMatrix := BlMatrix2D new.
	IdentityMatrix beReadOnlyObject
]

{ #category : #accessing }
BlElementCachedIdentityTransformation class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #'api - converting' }
BlElementCachedIdentityTransformation >> asElementTransformation [
	^ BlElementIdentityTransformation uniqueInstance
]

{ #category : #'api - transformation' }
BlElementCachedIdentityTransformation >> bounds: aRectangle [
	"The actual transformation matrix may depends on the element bounds due to
	potential non zero transformation origin.
	This allows cached transformation to recompute the transformation matrix when bounds change"
]

{ #category : #'api - transformation' }
BlElementCachedIdentityTransformation >> inverseTransformBounds: aBounds [
	"In-place transform given BlBounds according to my transformation.
	(global to local transformation)"
	<return: #BlBounds>
	
	^ aBounds
]

{ #category : #'api - transformation' }
BlElementCachedIdentityTransformation >> inverseTransformPoint: aPoint [
	"Apply an inversed transformation on a given point and return a result.
	Note: Throws BlSingularMatrixError if underlying matrix is singular"
	<return: #Point>
	
	^ aPoint
]

{ #category : #'api - testing' }
BlElementCachedIdentityTransformation >> isIdentity [
	<return: #Boolean>

	^ true
]

{ #category : #'api - transformation' }
BlElementCachedIdentityTransformation >> matrix [
	<return: #BlMatrix>
	
	^ IdentityMatrix
]

{ #category : #'api - transformation' }
BlElementCachedIdentityTransformation >> transformBounds: aBounds [
	"In-place transform given BlBounds according to my transformation.
	(local to global transformation)"
	<return: #BlBounds>
	
	^ aBounds
]

{ #category : #'api - transformation' }
BlElementCachedIdentityTransformation >> transformPoint: aPoint [
	"Transform given 2D point according to my transformation and return a transformed result point.
	(local to global transformation)"
	<return: #Point>
	
	^ aPoint
]
