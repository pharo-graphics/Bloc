tree - searching
findOverlapping: aMonotoneTextSelection
	<return: #Collection of: #BlMonotoneTextSelection>
	
	^ Array streamContents: [ :aStream | self overlappingNeighbours: aMonotoneTextSelection in: aStream ]