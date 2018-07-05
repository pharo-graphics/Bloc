tests
testCollectionFromToAbitLong
	| rope subrope string |
	
	string := String loremIpsum: BlRope combineLength * 3.
	rope := BlCollectionRope collection: string.
	subrope := rope from: 1 to: BlRope combineLength + 1.

	self assert: (subrope isKindOf: BlSubRope).
	self assert: subrope size equals: BlRope combineLength + 1.
	self assert: subrope rope == rope.
	self assert: subrope rope collection == string