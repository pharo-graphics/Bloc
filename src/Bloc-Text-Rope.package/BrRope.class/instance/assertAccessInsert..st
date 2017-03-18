private - asserting
assertAccessInsert: anIndex
	"I am an index invariant; I make sure that rope operation that require
	access by index do not go out of rope bounds"

	anIndex < 1
		ifTrue: [ self error: 'Illegal sub-sequence start index: ', anIndex asString ].
	anIndex > self size
		ifTrue: [ self error: 'Illegal sub-sequence end index: ', anIndex asString ]