"
I represent an element transformation and support both 2D and 3D transformations.

For optimization purposes I use 2D matrix if 3D transformation was not requested. As soon as I'm transformed in 3D all further transformation will also happen with the help of 3D matrix.
"
Class {
	#name : #BlTransformation,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'matrix2D',
		'matrix3D'
	],
	#category : #'Bloc-Basic-Transformations'
}

{ #category : #initialization }
BlTransformation >> defaultMatrix2D [
	^ BlMatrix2D new
]

{ #category : #initialization }
BlTransformation >> defaultMatrix3D [
	^ BlMatrix3D new
]

{ #category : #private }
BlTransformation >> ensure2D [
	"I make sure that matrix2D is initialized and ready to be used.
	Note: matrix3D must not exists when using me!"
	
	self
		assert: [ self is3D not ]
		description: [ 'I can not downgrade from 3D transformation to 2D!' ].
		
	matrix2D ifNil: [ matrix2D := self defaultMatrix2D ]
]

{ #category : #private }
BlTransformation >> ensure3D [
	"I make sure that matrix3D is initialized and ready to be used.
	Note: if I only have a 2D matrix I first convert it to 3D and then delete"
	
	matrix3D
		ifNotNil: [ ^ self ].
	
	matrix3D := matrix2D
		ifNotNil: [ self shouldBeImplemented ]
		ifNil: [ self defaultMatrix3D ]
]

{ #category : #private }
BlTransformation >> hasMatrix [
	"Return true if any of 2D or 3D matrices exist, false otherwise.
	Note: I am useful for fast exits"
	<return: #Boolean>
	
	^ matrix2D isNotNil or: [ matrix3D isNotNil ]
]

{ #category : #initialization }
BlTransformation >> initialize [
	super initialize.
	
	"we initialize lazily"	
	self loadIdentity
]

{ #category : #transformation }
BlTransformation >> inverseTransformBounds: aBounds [
	"In-place transform given BlBounds according to my transformation.
	(global to local transformation)"
	<return: #BlBounds>

	self hasMatrix
		ifFalse: [ ^ aBounds ].

	self is2D
		ifTrue: [ 
			self ensure2D.
			matrix2D inverted transformBounds: aBounds ]
		ifFalse: [ 
			self ensure3D.
			matrix3D inverted transformBounds: aBounds ].
		
	^ aBounds
]

{ #category : #transformation }
BlTransformation >> inverseTransformPoint: aPoint [
	"Apply an inversed transformation on a given point and return a result.
	Note: Throws BlSingularMatrixError if underlying matrix is singular"
	<return: #Point>
	
	aPoint isPoint
		ifFalse: [ self error: 'Only points can be transformed!' ].

	self hasMatrix
		ifNil: [ ^ aPoint ].
	
	^ (self is2D and: [ aPoint isPoint2D ])
		ifTrue: [ 
			self ensure2D.
			matrix2D inverted transformPoint: aPoint ]
		ifFalse: [ self shouldBeImplemented ]
]

{ #category : #transformation }
BlTransformation >> invert [
	self hasMatrix
		ifFalse: [ ^ self ].
		
	self is2D
		ifTrue: [ 
			self ensure2D.
			matrix2D := matrix2D inverted ]
		ifFalse: [ 
			self ensure3D.
			matrix3D := matrix3D inverted ]
]

{ #category : #transformation }
BlTransformation >> inverted [
	^ self copy invert
]

{ #category : #testing }
BlTransformation >> is2D [
	"Return true if my current transformation is in 2D space, false otherwise"
	<return: #Boolean>

	^ matrix3D isNil
]

{ #category : #testing }
BlTransformation >> is3D [
	"Return true if my current transformation is in 3D space, false otherwise"
	<return: #Boolean>

	^ matrix3D isNotNil
]

{ #category : #testing }
BlTransformation >> isIdentity [
	"Return true if I represent an identity transformation, false otherwise"
	<return: #Boolean>

	self hasMatrix
		ifFalse: [ ^ true ].
	
	^ self is2D
		ifTrue: [ 
			self ensure2D.
			matrix2D isIdentity ]
		ifFalse: [ 
			self shouldBeImplemented ]
]

{ #category : #testing }
BlTransformation >> isPureTranslation [
	"Return true if the receiver specifies no rotation or scaling and represents only translation in xy 2D plane"
	<return: #Boolean>
	
	self hasMatrix
		ifFalse: [ ^ true ].
	
	^ self is2D
		ifTrue: [ 
			self ensure2D.
			matrix2D isPureTranslation ]
		ifFalse: [ 
			self shouldBeImplemented ]
]

{ #category : #initialization }
BlTransformation >> loadIdentity [
	matrix2D := nil.
	matrix3D := nil
]

{ #category : #copying }
BlTransformation >> postCopy [
	matrix2D := matrix2D copy.
	matrix3D := matrix3D copy
]

{ #category : #scaling }
BlTransformation >> scaleBy: aFactor [
	"Apply a scaling by the given factor.
	Note: aDelta may be a Point, a BlPoint3D, aNumber or a BlockClosure that returns
	one of the supported types.
	In case of unknown type I thrown an Error.
	Q: why not to dispatch? A: it would pollute a Kernel with extention methods... we already added isPoint2D and isPoint3D..."

	aFactor isPoint
		ifTrue: [ aFactor isPoint2D
			ifTrue: [ self scaleX: aFactor x Y: aFactor y Z: 1.0 ]
			ifFalse: [ aFactor isPoint3D
				ifTrue: [ self scaleX: aFactor x Y: aFactor y Z: aFactor z ]
				ifFalse: [ self error: 'Unsupported Point type: ', aFactor asString ] ] ]

		"exotic cases when factor is not a point"
		ifFalse: [ aFactor isNumber
			ifTrue: [ self scaleX: aFactor Y: aFactor Z: aFactor ]
			ifFalse: [ aFactor isBlock 
				ifTrue: [ self scaleBy: aFactor value ]
				ifFalse: [ self error: 'Unsupported delta type: ', aFactor asString ] ] ]
]

{ #category : #scaling }
BlTransformation >> scaleTo: aPoint [
	"Define the scale factor using the given point.
	Note: aPoint may be a Point, a BlPoint3D or a BlockClosure that returns 
	one of the supported types."
]

{ #category : #scaling }
BlTransformation >> scaleX: aX [
	
	self scaleX: aX Y: 1.0 Z: 1.0
]

{ #category : #scaling }
BlTransformation >> scaleX: aX Y: aY [

	self scaleX: aX Y: aY Z: 1.0
]

{ #category : #scaling }
BlTransformation >> scaleX: aX Y: aY Z: aZ [
]

{ #category : #scaling }
BlTransformation >> scaleY: aY [

	self scaleX: 1.0 Y: aY Z: 1.0
]

{ #category : #scaling }
BlTransformation >> scaleZ: aZ [

	self scaleX: 1.0 Y: 1.0 Z: aZ
]

{ #category : #transformation }
BlTransformation >> transformBounds: aBounds [
	"In-place transform given BlBounds according to my transformation.
	(local to global transformation)"
	<return: #BlBounds>

	self hasMatrix
		ifFalse: [ ^ aBounds ].

	self is2D
		ifTrue: [ 
			self ensure2D.
			matrix2D transformBounds: aBounds ]
		ifFalse: [ 
			self ensure3D.
			matrix3D transformBounds: aBounds ].
		
	^ aBounds
]

{ #category : #transformation }
BlTransformation >> transformPoint: aPoint [
	"Transform given 2D point according to my transformation and return a transformed result point.
	(local to global transformation)"
	<return: #Point>

	self hasMatrix
		ifFalse: [ ^ aPoint ].

	^ self is2D
		ifTrue: [ 
			self ensure2D.
			matrix2D transformPoint: aPoint ]
		ifFalse: [ 
			self ensure3D.
			matrix3D transformPoint: aPoint ]
]

{ #category : #translation }
BlTransformation >> translateBy: aDelta [
	"Apply a translation by the given delta.
	Note: aDelta may be a Point, a BlPoint3D, aNumber or a BlockClosure that returns
	one of the supported types.
	In case of unknown type I thrown an Error.
	Q: why not to dispatch? A: it would pollute a Kernel with extention methods... we already added isPoint2D and isPoint3D..."

	aDelta isPoint
		ifTrue: [ aDelta isPoint2D
			ifTrue: [ self translateX: aDelta x Y: aDelta y Z: 0.0 ]
			ifFalse: [ aDelta isPoint3D
				ifTrue: [ self translateX: aDelta x Y: aDelta y Z: aDelta z ]
				ifFalse: [ self error: 'Unsupported Point type: ', aDelta asString ] ] ]
		ifFalse: [ aDelta isNumber
			ifTrue: [ self translateX: aDelta Y: aDelta Z: aDelta ]
			ifFalse: [ aDelta isBlock 
				ifTrue: [ self translateBy: aDelta value ]
				ifFalse: [ self error: 'Unsupported delta type: ', aDelta asString ] ] ]
]

{ #category : #translation }
BlTransformation >> translateTo: aPoint [
]

{ #category : #translation }
BlTransformation >> translateX: aX [
	
	self translateX: aX Y: 0.0 Z: 0.0
]

{ #category : #translation }
BlTransformation >> translateX: aX Y: aY [

	self translateX: aX Y: aY Z: 0.0
]

{ #category : #translation }
BlTransformation >> translateX: aX Y: aY Z: aZ [
]

{ #category : #translation }
BlTransformation >> translateY: aY [

	self translateX: 0.0 Y: aY Z: 0.0
]

{ #category : #translation }
BlTransformation >> translateZ: aZ [

	self translateX: 0.0 Y: 0.0 Z: aZ
]
