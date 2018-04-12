tree - searching
findOverlapping: aMonotoneTextSelection
	<return: #Collection of: #BlMonotoneSelection>
	
	^ Array streamContents: [ :aStream | self overlapping: aMonotoneTextSelection in: aStream ]