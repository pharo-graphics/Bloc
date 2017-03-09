tests
testCollectionFromToAbitLong
	| rope subrope string |
	
	string := String loremIpsum: BrRope combineLength * 3.
	rope := BrCollectionRope collection: string.
	subrope := rope from: 1 to: BrRope combineLength + 1.

	self assert: (subrope isKindOf: BrSubRope).
	self assert: subrope size equals: BrRope combineLength + 1.
	self assert: subrope rope == rope.
	self assert: subrope rope collection == string