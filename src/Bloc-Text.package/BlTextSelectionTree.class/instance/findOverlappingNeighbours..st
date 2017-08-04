tree - searching
findOverlappingNeighbours: aMonotoneTextSelection
	<return: #Collection of: #BlMonotoneTextSelection>
	
	^ Array streamContents: [ :aStream | self overlappingNeighbours: aMonotoneTextSelection in: aStream ]