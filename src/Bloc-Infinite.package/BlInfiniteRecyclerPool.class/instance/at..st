recycling
at: anIntemType
	<return: #BlInfiniteElementHolder or: nil>

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