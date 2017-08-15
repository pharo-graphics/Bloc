tree - searching
at: aComparable ifAbsentPut: anAbsentBlock
		
	^ self
		at: aComparable
		ifAbsent: [
			| aNode |
			aNode := anAbsentBlock value.
			self insert: aNode.
			aNode ]