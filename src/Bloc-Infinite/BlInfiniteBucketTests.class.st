Class {
	#name : #BlInfiniteBucketTests,
	#superclass : #TestCase,
	#instVars : [
		'bucket'
	],
	#category : 'Bloc-Infinite-Utils'
}

{ #category : #initialization }
BlInfiniteBucketTests >> actual [
	^ (1 to: self max) collect: [ :i | bucket get: i ]
]

{ #category : #initialization }
BlInfiniteBucketTests >> max [
	^ 650
]

{ #category : #initialization }
BlInfiniteBucketTests >> setUp [
	bucket := BlInfiniteBucket new
]

{ #category : #initialization }
BlInfiniteBucketTests >> tearDown [
	bucket := nil
]

{ #category : #tests }
BlInfiniteBucketTests >> testGet [
	| expected actual |
	expected := Array new: self max withAll: false.
	actual := self actual.
	self assert: actual equals: expected
]

{ #category : #tests }
BlInfiniteBucketTests >> testInsert [
	| expected actual |
	expected := Array new: self max withAll: true.
	1 to: self max do: [ :i | expected at: i put: (i % 2 = 0) ].

	1 to: self max do: [ :i | bucket insert: (i % 2 ~= 0) at: 1 ].

	actual := self actual.
	self assert: actual equals: expected
]

{ #category : #tests }
BlInfiniteBucketTests >> testRemove [
	| expected actual |
	expected := Array new: self max withAll: false.

	1 to: self max do: [ :i | bucket set: i ].
	(1 to: self max) reverseDo: [ :i |
		| mustBe |
		mustBe := Array new: self max withAll: true.
		i to: self max do: [ :j | mustBe at: j put: false ].
		bucket remove: i.
		self assert: self actual equals: mustBe ].

	actual := self actual.
	self assert: actual equals: expected
]

{ #category : #tests }
BlInfiniteBucketTests >> testSet [
	| expected actual |
	expected := Array new: self max withAll: false.
	1 to: self max do: [ :i | expected at: i put: (i % 2 = 0) ].
	
	1 to: self max do: [ :i | (i % 2 = 0) ifTrue: [ bucket set: i ] ].

	actual := self actual.
	self assert: actual equals: expected
]
