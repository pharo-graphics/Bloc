tree - searching
findOverlappingNeighbours: aMonotoneTextSelection
	<return: #Collection of: #BlMonotoneSelection>
	
	^ Array streamContents: [ :aStream | self overlappingNeighbours: aMonotoneTextSelection in: aStream ]