accessing
heapAt: anItemType
	<return: #'OrderedCollection<BlInfiniteElementHolder>'>

	^ scrap
		at: anItemType
		ifAbsentPut: [ 
			| aHeap |
			aHeap := OrderedCollection new.
			maxScrap at: anItemType ifAbsentPut: [ self defaultMaxScrap ].
			aHeap ]