tree - searching
overlapping: aMonotoneTextSelection in: aStream
	
	self hasRoot
		ifTrue: [ self root overlapping: aMonotoneTextSelection in: aStream ]