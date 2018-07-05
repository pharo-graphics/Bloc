tests
testCollectionFromToExact
	| rope subrope string |
	
	string := String loremIpsum: BlRope combineLength * 3.
	rope := BlCollectionRope collection: string.
	subrope := rope from: 1 to: BlRope combineLength.

	self assert: (subrope isKindOf: BlCollectionRope).
	self assert: subrope size equals: BlRope combineLength.
	self assert: subrope collection equals: (string copyFrom: 1 to: BlRope combineLength)