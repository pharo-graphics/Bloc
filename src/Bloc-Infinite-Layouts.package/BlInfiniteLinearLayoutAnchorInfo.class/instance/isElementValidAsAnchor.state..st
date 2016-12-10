testing
isElementValidAsAnchor: anElement state: anInfiniteState
	| anInfiniteConstraints |
	
	anInfiniteConstraints := anElement constraints infinite.
	^ anInfiniteConstraints isRemoved not and: [
		anInfiniteConstraints elementLayoutPosition
			between: 1
			and: anInfiniteState itemCount ]