private - asserting
assertIndexForInsert: anIndex

	(anIndex < 0 or: [ anIndex > self size ])
		ifTrue: [ self error: 'Insert index ', anIndex asString, ' is out of bounds' ]