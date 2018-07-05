rope - inserting
insertItems: aCollection at: anIndex
	| anInsertionRope |
	self assertIndexForInsert: anIndex.

	"new collection is smaller than combine length, let's merge them"
	self size + aCollection size <= self class combineLength
		ifTrue: [ ^ self merge: aCollection at: anIndex ].
		
	self size + aCollection size <= (self class combineLength * 2)
		ifTrue: [ ^ self mergeSplit: aCollection at: anIndex ].
	
	anInsertionRope := self class collectionRope collection: aCollection.
	
	anIndex = 0
		ifTrue: [ ^ anInsertionRope append: self ].
		
	anIndex = self size
		ifTrue: [ ^ self append: anInsertionRope ].
		
	^ (self from: 1 to: anIndex) append: (anInsertionRope append: (self from: anIndex + 1 to: self size))