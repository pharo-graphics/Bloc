tests
testCollectionFromToExact
	| rope subrope string |
	
	string := String loremIpsum: BrRope combineLength * 3.
	rope := BrCollectionRope collection: string.
	subrope := rope from: 1 to: BrRope combineLength.

	self assert: (subrope isKindOf: BrCollectionRope).
	self assert: subrope size equals: BrRope combineLength.
	self assert: subrope collection equals: (string copyFrom: 1 to: BrRope combineLength)