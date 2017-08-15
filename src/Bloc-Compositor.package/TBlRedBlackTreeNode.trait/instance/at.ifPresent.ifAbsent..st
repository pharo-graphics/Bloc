tree - searching
at: aComparable ifPresent: aPresentBlock ifAbsent: anAbsentBlock
	aComparable = self key
		ifTrue: [ ^ aPresentBlock value: self ].
		
	^ aComparable < self key
		ifTrue: [ 
			self hasLeft
				ifTrue: [ self left at: aComparable ifPresent: aPresentBlock ifAbsent: anAbsentBlock ]
				ifFalse: [ anAbsentBlock value ] ]
		ifFalse: [ 
			self hasRight
				ifTrue: [ self right at: aComparable ifPresent: aPresentBlock ifAbsent: anAbsentBlock ]
				ifFalse: [ anAbsentBlock value ] ]