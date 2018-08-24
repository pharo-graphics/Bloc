"
I represent an element transformation and support both 2D and 3D transformations.

For optimization purposes I use 2D matrix if 3D transformation was not requested. As soon as I'm transformed in 3D all further transformation will also happen with the help of 3D matrix.
"
Class {
	#name : #BlElementTransformation,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'owner',
		'matrix'
	],
	#category : 'Bloc-Basic-Transformations'
}

{ #category : #accessing }
BlElementTransformation >> inSpace [
	"Return a transformation that represents a convertion from space coordinates
	to the local coordinates of the owner element of this transformation"
	<return: #BlElementTransformation>
	| aMatrix |
	
	aMatrix := self matrix copy.
	aMatrix translateBy: self owner position.
	
	self owner parentsDo: [ :anElement |
		aMatrix multiplyBy: anElement transformation matrix.
		aMatrix translateBy: anElement position ].
	
	^ BlElementAbsoluteTransformation matrix: aMatrix
]

{ #category : #invalidation }
BlElementTransformation >> invalidateMatrix [
	self subclassResponsibility
]

{ #category : #bounds }
BlElementTransformation >> inverseTransformBounds: aBounds [
	"In-place transform given BlBounds according to my transformation.
	(global to local transformation)"
	<return: #BlBounds>

	^ self matrix inverted transformBounds: aBounds
]

{ #category : #bounds }
BlElementTransformation >> inverseTransformPoint: aPoint [
	"Apply an inversed transformation on a given point and return a result.
	Note: Throws BlSingularMatrixError if underlying matrix is singular"
	<return: #Point>

	aPoint isPoint
		ifFalse: [ self error: 'Only points can be transformed!' ].

	^ self matrix inverted transformPoint: aPoint
]

{ #category : #bounds }
BlElementTransformation >> invert [
	matrix := self matrix inverted
]

{ #category : #bounds }
BlElementTransformation >> inverted [
	^ self copy invert
]

{ #category : #testing }
BlElementTransformation >> is2D [
	"Return true if my current transformation is in 2D space, false otherwise"
	<return: #Boolean>
	
	^ self subclassResponsibility
]

{ #category : #testing }
BlElementTransformation >> is3D [
	<return: #Boolean>
	
	^ self subclassResponsibility
]

{ #category : #testing }
BlElementTransformation >> isIdentity [
	"Return true if I represent an identity transformation, false otherwise"
	<return: #Boolean>
	
	^ self subclassResponsibility
]

{ #category : #testing }
BlElementTransformation >> isPureTranslation [
	"Return true if the receiver specifies no rotation or scaling and represents only translation in xy 2D plane"
	<return: #Boolean>
	
	^ false
]

{ #category : #accessing }
BlElementTransformation >> matrix [
	<return: #BlMatrix>

	^ self subclassResponsibility
]

{ #category : #accessing }
BlElementTransformation >> owner [
	<return: #BlElement>
	
	^ owner
]

{ #category : #accessing }
BlElementTransformation >> owner: anElement [
	owner := anElement
]

{ #category : #copying }
BlElementTransformation >> postCopy [
	matrix := matrix copy
]

{ #category : #bounds }
BlElementTransformation >> transformBounds: aBounds [
	"In-place transform given BlBounds according to my transformation.
	(local to global transformation)"
	<return: #BlBounds>

	^ self matrix transformBounds: aBounds
]

{ #category : #bounds }
BlElementTransformation >> transformPoint: aPoint [
	"Transform given 2D point according to my transformation and return a transformed result point.
	(local to global transformation)"
	<return: #Point>
	
	^ self matrix transformPoint: aPoint
]
