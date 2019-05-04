Class {
	#name : #BlInfiniteRecyclerPool,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'scrap',
		'maxScrap',
		'attachCount'
	],
	#category : 'Bloc-Infinite-Recycler'
}

{ #category : #recycling }
BlInfiniteRecyclerPool >> at: anIntemType [
	<return: #BlInfiniteHolder or: nil>

	^ scrap at: anIntemType
		ifPresent: [ :aScrapHeap |
			aScrapHeap
				ifEmpty: [ nil ]
				ifNotEmpty: [ 
					| anIndex anElementHolder |
					anIndex := aScrapHeap size.
					anElementHolder := aScrapHeap at: anIndex.
					aScrapHeap removeAt: anIndex.
					anElementHolder ] ]
		ifAbsent: [ nil ]
]

{ #category : #invalidate }
BlInfiniteRecyclerPool >> clear [
	scrap removeAll
]

{ #category : #hooks }
BlInfiniteRecyclerPool >> dataSourceChangedFrom: anOldDataSource to: aNewDataSource isCompatible: aBoolean [
	self shouldBeImplemented
]

{ #category : #initialization }
BlInfiniteRecyclerPool >> defaultMaxScrap [
	^ 5
]

{ #category : #accessing }
BlInfiniteRecyclerPool >> heapAt: anItemType [
	<return: #OrderedCollection of: #BlInfiniteElementHolder>

	^ scrap
		at: anItemType
		ifAbsentPut: [ 
			| aHeap |
			aHeap := OrderedCollection new.
			maxScrap at: anItemType ifAbsentPut: [ self defaultMaxScrap ].
			aHeap ]
]

{ #category : #initialization }
BlInfiniteRecyclerPool >> initialize [
	super initialize.
	
	scrap := Dictionary new.
	maxScrap := Dictionary new.
	attachCount := 0.
]

{ #category : #recycling }
BlInfiniteRecyclerPool >> max: aNumber type: anItemType [
	| aScrapHeap |
	
	self
		assert: [ aNumber >= 0 ]
		description: [ 'Max amount of scrap must be non-negative' ].
	
	maxScrap at: anItemType put: aNumber.
	aScrapHeap := self heapAt: anItemType.
	
	[ aScrapHeap size > aNumber ] whileTrue: [
		aScrapHeap removeLast ]
]

{ #category : #recycling }
BlInfiniteRecyclerPool >> put: anElementHolder [
	| anItemType aScrapHeap |
	
	anItemType := anElementHolder itemType.
	aScrapHeap := self heapAt: anItemType.
	
	(maxScrap at: anItemType) <= aScrapHeap size
		ifTrue: [ ^ self ].
	
	self
		assert: [ (aScrapHeap includes: anElementHolder) not ]
		description: [ 'Scrap element already exists!' ].
	
	anElementHolder reset.
	aScrapHeap add: anElementHolder
]

{ #category : #accessing }
BlInfiniteRecyclerPool >> size [
	<return: #Number>

	^ scrap
		ifEmpty: [ 0 ]
		ifNotEmpty: [ :aDictionary | aDictionary sum: [ :each | each size ] ]
]
