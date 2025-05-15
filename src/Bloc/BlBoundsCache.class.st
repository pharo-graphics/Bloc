"
My responsibility is providing several kinds of bounds of a `BlElement`.

I point to bound objects, that are created lazily to speed up creation of complex element trees.
When those bounds are invalidated, the instances are kept, to speed up trees with many animations, that invalidate on each new animation frame.
"
Class {
	#name : #BlBoundsCache,
	#superclass : #Object,
	#instVars : [
		'boundsInSpace',
		'boundsInLocal',
		'geometryBounds',
		'geometryBoundsInSpace',
		'lastDrawBoundsInSpace',
		'invalidationBoundsInSpace',
		'element'
	],
	#category : #'Bloc-Basic-Bounds'
}

{ #category : #'instance creation' }
BlBoundsCache class >> on: anElement [

	^ self basicNew
		initializeWith: anElement;
		yourself
]

{ #category : #accessing }
BlBoundsCache >> boundsInLocal [

	boundsInLocal ifNil: [ boundsInLocal := BlCachedBounds new ].

	boundsInLocal ensureValidWith: [ :b | element boundsInLocal: b ].

	^ boundsInLocal
]

{ #category : #accessing }
BlBoundsCache >> boundsInSpace [

	boundsInSpace ifNil: [ boundsInSpace := BlCachedBounds new ].

	boundsInSpace ensureValidWith: [ :b |
		element boundsInLocal: b.
		element localBoundsToGlobal: b ].

	^ boundsInSpace
]

{ #category : #accessing }
BlBoundsCache >> damagedBoundsInSpace [

	^ lastDrawBoundsInSpace
		ifNotNil: [ self invalidationBoundsInSpace copy merge: lastDrawBoundsInSpace ]
		ifNil: [ self invalidationBoundsInSpace ]
]

{ #category : #accessing }
BlBoundsCache >> geometryBounds [

	geometryBounds ifNil: [ geometryBounds := BlCachedBounds new ].

	geometryBounds ensureValidWith: [ :b | element geometryBounds: b ].
	
	^ geometryBounds
]

{ #category : #accessing }
BlBoundsCache >> geometryBoundsInSpace [

	geometryBoundsInSpace ifNil: [
		geometryBoundsInSpace := BlCachedBounds new ].

	geometryBoundsInSpace ensureValidWith: [ :b |
		element geometryBounds: b.
		element localBoundsToGlobal: b ].

	^ geometryBoundsInSpace
]

{ #category : #initialization }
BlBoundsCache >> initializeWith: anElement [

	self initialize.

	element := anElement
]

{ #category : #invalidation }
BlBoundsCache >> invalidateLocalBounds [

	boundsInLocal ifNotNil: [ :b | b invalidate ].
	geometryBounds ifNotNil: [ :b | b invalidate ].

	self invalidateParentBounds
]

{ #category : #invalidation }
BlBoundsCache >> invalidateParentBounds [

	boundsInSpace ifNotNil: [ :b | b invalidate ].
	geometryBoundsInSpace ifNotNil: [ :b | b invalidate ].
	invalidationBoundsInSpace ifNotNil: [ :b | b invalidate ].

	element childrenDo: [ :anElement |
		anElement boundsCache invalidateParentBounds ]
]

{ #category : #accessing }
BlBoundsCache >> invalidationBoundsInSpace [

	invalidationBoundsInSpace ifNil: [
		invalidationBoundsInSpace := BlCachedBounds new ].

	invalidationBoundsInSpace ensureValidWith: [ :b |
			element invalidationBounds: b.
			element localBoundsToGlobal: b ].

	^ invalidationBoundsInSpace
]

{ #category : #accessing }
BlBoundsCache >> markLastDrawBounds [

	lastDrawBoundsInSpace ifNil: [
		lastDrawBoundsInSpace := BlBounds new ].

	lastDrawBoundsInSpace bounds: self invalidationBoundsInSpace
]
