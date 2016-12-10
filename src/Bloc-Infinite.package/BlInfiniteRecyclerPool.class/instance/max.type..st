recycling
max: aNumber type: anItemType
	| aScrapHeap |
	
	self
		assert: [ aNumber >= 0 ]
		description: [ 'Max amount of scrap must be non-negative' ].
	
	maxScrap at: anItemType put: aNumber.
	aScrapHeap := self heapAt: anItemType.
	
	[ aScrapHeap size > aNumber ] whileTrue: [
		aScrapHeap removeLast ]