"
!Cached element transformation
Builds upon the ${class:BlElementTransformation}$ to provide the matrix caching posibility.
"
Class {
	#name : #BlElementCachedTransformation,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'transformation',
		'bounds',
		'matrix'
	],
	#category : #'Bloc-Basic-Transformations'
}

{ #category : #'instance creation' }
BlElementCachedTransformation class >> forTransformation: aBlElementTransformation [
	^ self new initializeWith: aBlElementTransformation
]

{ #category : #converting }
BlElementCachedTransformation >> asCachedTransformation [
	^ self
]

{ #category : #accessing }
BlElementCachedTransformation >> bounds [
	^ bounds
]

{ #category : #accessing }
BlElementCachedTransformation >> bounds: aRectangle [
	bounds := aRectangle.
	self invalidateMatrix
]

{ #category : #private }
BlElementCachedTransformation >> ensureMatrix [
	self hasMatrix
		ifTrue: [ ^ self ].

	matrix := self transformation asMatrix: bounds
]

{ #category : #testing }
BlElementCachedTransformation >> hasMatrix [
	"Return true if any of 2D or 3D matrices exist, false otherwise.
	Note: I am useful for fast exits"
	<return: #Boolean>

	^ matrix isNotNil
]

{ #category : #initialization }
BlElementCachedTransformation >> initialize [
	super initialize.
	
	bounds := 0.0@0.0 extent: 0.0@0.0
]

{ #category : #initialization }
BlElementCachedTransformation >> initializeWith: aBlElementTransformation [
	self
		assert: [ transformation isNil ]
		description: [ 'Transfomation can not be changed once set' ].

	transformation := aBlElementTransformation
]

{ #category : #private }
BlElementCachedTransformation >> invalidateMatrix [
	"Matrix is computed out of affine transformation composition
	which may contain transformations that depend on element's properties
	such as extent. It means that when element changes we need to invalidate and
	recompute the matrix => set it to nil to trigger computation on next matrix access"

	matrix := nil
]

{ #category : #bounds }
BlElementCachedTransformation >> inverseTransformBounds: aBounds [
	"In-place transform given BlBounds according to my transformation.
	(global to local transformation)"
	<return: #BlBounds>

	^ self matrix inverted transformBounds: aBounds
]

{ #category : #bounds }
BlElementCachedTransformation >> inverseTransformPoint: aPoint [
	"Apply an inversed transformation on a given point and return a result.
	Note: Throws BlSingularMatrixError if underlying matrix is singular"
	<return: #Point>

	aPoint isPoint
		ifFalse: [ self error: 'Only points can be transformed!' ].

	^ self matrix inverted transformPoint: aPoint
]

{ #category : #private }
BlElementCachedTransformation >> invert [
	matrix := self matrix inverted
]

{ #category : #private }
BlElementCachedTransformation >> inverted [
	^ self copy invert
]

{ #category : #accessing }
BlElementCachedTransformation >> matrix [
	<return: #BlMatrix>

	self ensureMatrix.
	^ matrix
]

{ #category : #bounds }
BlElementCachedTransformation >> transformBounds: aBounds [
	"In-place transform given BlBounds according to my transformation.
	(local to global transformation)"
	<return: #BlBounds>

	^ self matrix transformBounds: aBounds
]

{ #category : #bounds }
BlElementCachedTransformation >> transformPoint: aPoint [
	"Transform given 2D point according to my transformation and return a transformed result point.
	(local to global transformation)"
	<return: #Point>
	
	^ self matrix transformPoint: aPoint
]

{ #category : #accessing }
BlElementCachedTransformation >> transformation [
	<return: #BlElementTransformation>

	^ transformation
]
