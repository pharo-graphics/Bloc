tree - searching
findOverlapping: aMonotoneTextSelection
	<return: #Collection of: #BlMonotoneTextSelection>
	
	^ Array streamContents: [ :aStream | self overlapping: aMonotoneTextSelection in: aStream ]