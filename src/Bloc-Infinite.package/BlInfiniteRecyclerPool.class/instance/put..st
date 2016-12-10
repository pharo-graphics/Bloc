recycling
put: anElementHolder
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