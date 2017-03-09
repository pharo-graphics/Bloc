private - asserting
assertAccessInsert: anIndex

	anIndex < 1
		ifTrue: [ self error: 'Illegal sub-sequence start index: ', anIndex asString ].
	anIndex > self size
		ifTrue: [ self error: 'Illegal sub-sequence end index: ', anIndex asString ]