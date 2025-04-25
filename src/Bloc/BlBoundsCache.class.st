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
		'lastDrawBoundsInSpace'
	],
	#category : #'Bloc-Basic-Support'
}

{ #category : #'instance creation' }
BlBoundsCache class >> on: anElement [

	^ self new
		owner: anElement;
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

	^ owner localBoundsToGlobal: self invalidationBounds copy
]

{ #category : #accessing }
BlBoundsCache >> markLastDrawBounds [

	lastDrawBoundsInSpace := self invalidationBoundsInSpace
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
		transformedBounds := owner transformedBounds: BlBounds new ]
]
