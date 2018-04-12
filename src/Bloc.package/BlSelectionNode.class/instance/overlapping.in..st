tree - searching
overlapping: aMonotoneTextSelection in: aStream
	
	(left isNotNil and: [ aMonotoneTextSelection from <= left high ])
		ifTrue: [ left overlapping: aMonotoneTextSelection in: aStream ].

	(self selection overlaps: aMonotoneTextSelection)
		ifTrue: [ aStream nextPut: self ].

	(right isNotNil and: [ aMonotoneTextSelection from <= right high ])
		ifTrue: [ right overlapping: aMonotoneTextSelection in: aStream ]