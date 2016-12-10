private - recycling
nextElementFromScrapList
	"Return the next element from the scrap list or nil if there is not such"
	<return: #BlElement or: nil>
	
	scrapList do: [ :anElementHolder |
		| anElement anInfiniteConstraints |
		
		anElement := anElementHolder itemElement.
		anInfiniteConstraints := anElement constraints infinite.
		(anInfiniteConstraints isItemRemoved not and: [
			currentPosition = anInfiniteConstraints elementLayoutPosition ])
				ifTrue: [ 
					self assignPositionFromScrapList: anElement.
					^ anElement ] ].
	^ nil