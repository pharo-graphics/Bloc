"
# Cached element transformation
Builds upon the {{gtClass:BlElementTransformation}} to provide the matrix caching posibility.

"
Class {
	#name : 'BlElementCachedExplicitTransformation',
	#superclass : 'BlElementCachedTransformation',
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'transformation',
		'bounds',
		'matrix'
	],
	#category : 'Bloc-Basic-Transformations'
}

{ #category : 'instance creation' }
BlElementCachedExplicitTransformation class >> forTransformation: aBlElementTransformation [
	^ self new initializeWith: aBlElementTransformation
]

{ #category : 'api - converting' }
BlElementCachedExplicitTransformation >> asElementTransformation [
	^ self transformation
]

{ #category : 'private - accessing' }
BlElementCachedExplicitTransformation >> bounds [
	^ bounds
]

{ #category : 'api - transformation' }
BlElementCachedExplicitTransformation >> bounds: aRectangle [
	bounds := aRectangle.
	self invalidateMatrix
]

{ #category : 'private - accessing' }
BlElementCachedExplicitTransformation >> ensureMatrix [
	self hasMatrix
		ifTrue: [ ^ self ].

	matrix := self transformation asMatrix: bounds
]

{ #category : 'private - testing' }
BlElementCachedExplicitTransformation >> hasMatrix [
	"Return true if any of 2D or 3D matrices exist, false otherwise.
	Note: I am useful for fast exits"
	<return: #Boolean>

	^ matrix isNotNil
]

{ #category : 'initialization' }
BlElementCachedExplicitTransformation >> initialize [
	super initialize.
	
	bounds := 0.0@0.0 extent: 0.0@0.0
]

{ #category : 'initialization' }
BlElementCachedExplicitTransformation >> initializeWith: aBlElementTransformation [
	self
		assert: [ transformation isNil ]
		description: [ 'Transfomation can not be changed once set' ].

	transformation := aBlElementTransformation
]

{ #category : 'private - accessing' }
BlElementCachedExplicitTransformation >> invalidateMatrix [
	"Matrix is computed out of affine transformation composition
	which may contain transformations that depend on element's properties
	such as extent. It means that when element changes we need to invalidate and
	recompute the matrix => set it to nil to trigger computation on next matrix access"

	matrix := nil
]

{ #category : 'api - transformation' }
BlElementCachedExplicitTransformation >> inverseTransformBounds: aBounds [
	"In-place transform given BlBounds according to my transformation.
	(global to local transformation)"
	<return: #BlBounds>

	^ self matrix inverted transformBounds: aBounds
]

{ #category : 'api - transformation' }
BlElementCachedExplicitTransformation >> inverseTransformPoint: aPoint [
	"Apply an inversed transformation on a given point and return a result.
	Note: Throws BlSingularMatrixError if underlying matrix is singular"
	<return: #Point>

	aPoint isPoint
		ifFalse: [ self error: 'Only points can be transformed!' ].

	^ self matrix inverted transformPoint: aPoint
]

{ #category : 'private - accessing' }
BlElementCachedExplicitTransformation >> invert [
	matrix := self matrix inverted
]

{ #category : 'private - accessing' }
BlElementCachedExplicitTransformation >> inverted [
	^ self copy invert
]

{ #category : 'api - testing' }
BlElementCachedExplicitTransformation >> isIdentity [
	^ self transformation isIdentity
]

{ #category : 'accessing' }
BlElementCachedExplicitTransformation >> isPureTranslation [
	^ self transformation isPureTranslation
]

{ #category : 'api - transformation' }
BlElementCachedExplicitTransformation >> matrix [
	<return: #BlMatrix>

	self ensureMatrix.
	^ matrix
]

{ #category : 'api - transformation' }
BlElementCachedExplicitTransformation >> transformBounds: aBounds [
	"In-place transform given BlBounds according to my transformation.
	(local to global transformation)"
	<return: #BlBounds>

	^ self matrix transformBounds: aBounds
]

{ #category : 'api - transformation' }
BlElementCachedExplicitTransformation >> transformPoint: aPoint [
	"Transform given 2D point according to my transformation and return a transformed result point.
	(local to global transformation)"
	<return: #Point>
	
	^ self matrix transformPoint: aPoint
]

{ #category : 'private - accessing' }
BlElementCachedExplicitTransformation >> transformation [
	<return: #BlElementTransformation>

	^ transformation
]
