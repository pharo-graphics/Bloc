tree - searching
overlappingNeighbours: aMonotoneTextSelection in: aStream
	
	self hasRoot
		ifTrue: [ self root overlappingNeighbours: aMonotoneTextSelection in: aStream ]