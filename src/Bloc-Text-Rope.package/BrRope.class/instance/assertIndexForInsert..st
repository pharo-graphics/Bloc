private - asserting
assertIndexForInsert: anIndex
	"I am an insertion index invariant; I make sure that insertion operations
	do not go out of rope bounds"
	
	(anIndex < 0 or: [ anIndex > self size ])
		ifTrue: [ self error: 'Insert index ', anIndex asString, ' is out of bounds' ]