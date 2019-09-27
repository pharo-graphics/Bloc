Class {
	#name : #BlBoundsCache,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'owner',
		'boundsInSpace',
		'boundsInLocal',
		'transformedBounds',
		'geometryBounds',
		'geometryBoundsInSpace',
		'boundsInParent'
	],
	#category : #'Bloc-Basic-Support'
}

{ #category : #'as yet unclassified' }
BlBoundsCache class >> on: anElement [
	^ self new owner: anElement
]

{ #category : #accessing }
BlBoundsCache >> boundsInLocal [
	^ boundsInLocal ifNil: [
		boundsInLocal := (self owner boundsInLocal: BlBounds new) asRectangle ]
]

{ #category : #accessing }
BlBoundsCache >> boundsInParent [
	self deprecated: 'Use `element bounds inParent` instead'.

	^ boundsInParent ifNil: [
		boundsInParent := (self owner boundsInParent: BlBounds new) asRectangle ]
]

{ #category : #accessing }
BlBoundsCache >> boundsInSpace [
	^ boundsInSpace ifNil: [
		boundsInSpace := (self owner boundsInSpace: BlBounds new) asRectangle ]
]

{ #category : #accessing }
BlBoundsCache >> geometryBounds [
	^ geometryBounds ifNil: [
		geometryBounds := (self owner geometryBounds: BlBounds new) asRectangle ]
]

{ #category : #accessing }
BlBoundsCache >> geometryBoundsInSpace [
	^ geometryBoundsInSpace
		ifNil: [ geometryBoundsInSpace := (self owner geometryBoundsInSpace: BlBounds new) asRectangle ]
]

{ #category : #invalidation }
BlBoundsCache >> invalidateBoundsInLocal [
	"Bounds properties in local coordinates change than and only than when extent changes"

	boundsInLocal := nil.
	geometryBounds := nil.

	self invalidateBoundsInSpace
]

{ #category : #invalidation }
BlBoundsCache >> invalidateBoundsInSpace [

	boundsInSpace := nil.
	geometryBoundsInSpace := nil.
	transformedBounds := nil.
	boundsInParent := nil.

	self owner childrenDo: [ :anElement |
		anElement boundsCache invalidateBoundsInSpace ]
]

{ #category : #accessing }
BlBoundsCache >> owner [
	^ owner
]

{ #category : #accessing }
BlBoundsCache >> owner: anElement [
	owner := anElement
]

{ #category : #accessing }
BlBoundsCache >> transformedBounds [
	^ transformedBounds ifNil: [
		transformedBounds := (self owner transformedBounds: BlBounds new) asRectangle ]
]
