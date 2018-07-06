private - asserting
assertAccessFrom: aStartIndex to: anEndIndex
	"I am an index invariant; I make sure that rope operation that require
	access by index do not go out of rope bounds"

	(aStartIndex <= anEndIndex)
		ifFalse: [ self error: 'Start index must be less or equal to an end index' ].

	(aStartIndex isZero and: [ anEndIndex isZero and: [ self isEmpty ] ])
		ifTrue: [ ^ self ].

	self assertAccess: aStartIndex.
	self assertAccess: anEndIndex