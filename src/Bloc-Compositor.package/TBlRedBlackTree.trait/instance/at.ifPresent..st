tree - searching
at: aComparable ifPresent: aPresentBlock

	^ self
		at: aComparable
		ifPresent: aPresentBlock
		ifAbsent: nil