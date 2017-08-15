tree - searching
at: aComparable ifPresent: aPresentBlock ifAbsentPut: anAbsentBlock
		
	^ self
		at: aComparable
		ifPresent: aPresentBlock
		ifAbsent: [
			| aNode |
			aNode := anAbsentBlock value.
			self insert: aNode.
			aNode ]