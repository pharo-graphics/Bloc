tree - searching
at: aComparable ifPresent: aPresentBlock ifAbsent: anAbsentBlock
	^ self hasRoot
		ifFalse: [ anAbsentBlock value ]
		ifTrue: [ self root at: aComparable ifPresent: aPresentBlock ifAbsent: anAbsentBlock ]