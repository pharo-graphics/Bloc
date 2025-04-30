"
My responsibility is providing several kinds of bounds of a `BlElement`.
"
Class {
	#name : #BlBoundsCache,
	#superclass : #Object,
	#instVars : [
		'owner',
		'boundsInSpace',
		'boundsInLocal',
		'transformedBounds',
		'geometryBounds',
		'geometryBoundsInSpace',
		'invalidationBounds',
		'lastDrawBoundsInSpace',
		'invalidationBoundsInSpace'
	],
	#category : #'Bloc-Basic-Support'
}

{ #category : #'instance creation' }
BlBoundsCache class >> on: anElement [

	^ self basicNew
		initializeWith: anElement;
		yourself
]

{ #category : #accessing }
BlBoundsCache >> boundsInLocal [

	^ boundsInLocal ifNil: [
		boundsInLocal := owner boundsInLocal: BlBounds new ]
]

{ #category : #accessing }
BlBoundsCache >> boundsInSpace [

	^ boundsInSpace ifNil: [
		boundsInSpace := owner boundsInSpace: BlBounds new ]
]

{ #category : #accessing }
BlBoundsCache >> damagedBoundsInSpace [

	^ lastDrawBoundsInSpace
		ifNotNil: [ self invalidationBoundsInSpace merge: lastDrawBoundsInSpace ]
		ifNil: [ self invalidationBoundsInSpace ]
]

{ #category : #accessing }
BlBoundsCache >> geometryBounds [

	^ geometryBounds ifNil: [
		geometryBounds := owner geometryBounds: BlBounds new ]
]

{ #category : #accessing }
BlBoundsCache >> geometryBoundsInSpace [

	^ geometryBoundsInSpace ifNil: [
		  geometryBoundsInSpace := owner geometryBoundsInSpace: BlBounds new ]
]

{ #category : #initialization }
BlBoundsCache >> initializeWith: anElement [

	self initialize.

	owner := anElement
]

{ #category : #invalidation }
BlBoundsCache >> invalidateLocalBounds [

	boundsInLocal := nil.
	geometryBounds := nil.
	invalidationBounds := nil.

	self invalidateParentBounds
]

{ #category : #invalidation }
BlBoundsCache >> invalidateParentBounds [

	boundsInSpace := nil.
	geometryBoundsInSpace := nil.
	transformedBounds := nil.
	invalidationBoundsInSpace := nil.

	owner childrenDo: [ :anElement |
		anElement boundsCache invalidateParentBounds ]
]

{ #category : #accessing }
BlBoundsCache >> invalidationBounds [

	^ invalidationBounds ifNil: [
		invalidationBounds := owner invalidationBounds: BlBounds new ]
]

{ #category : #accessing }
BlBoundsCache >> invalidationBoundsInSpace [

	^ invalidationBoundsInSpace ifNil: [
		invalidationBoundsInSpace :=
			owner localBoundsToGlobal: self invalidationBounds copy ]
]

{ #category : #accessing }
BlBoundsCache >> markLastDrawBounds [

	lastDrawBoundsInSpace := self invalidationBoundsInSpace
]

{ #category : #accessing }
BlBoundsCache >> transformedBounds [

	^ transformedBounds ifNil: [
		transformedBounds := owner transformedBounds: BlBounds new ]
]
