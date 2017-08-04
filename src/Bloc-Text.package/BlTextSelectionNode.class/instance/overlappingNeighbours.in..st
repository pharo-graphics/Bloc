tree - searching
overlappingNeighbours: aMonotoneTextSelection in: aStream
	
	(left isNotNil and: [ aMonotoneTextSelection from <= (left high + 1) ])
		ifTrue: [ left overlappingNeighbours: aMonotoneTextSelection in: aStream ].

	((self selection overlaps: aMonotoneTextSelection) or: [ self selection neighbours: aMonotoneTextSelection ])
		ifTrue: [ aStream nextPut: self ].

	(right isNotNil and: [ aMonotoneTextSelection from <= (right high + 1) ])
		ifTrue: [ right overlappingNeighbours: aMonotoneTextSelection in: aStream ]