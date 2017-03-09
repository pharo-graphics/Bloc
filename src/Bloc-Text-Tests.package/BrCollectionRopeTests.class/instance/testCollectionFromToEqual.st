tests
testCollectionFromToEqual
	| rope subrope |
	
	rope := BrCollectionRope collection: 'Haba'.
	subrope := rope from: 1 to: 4.
	
	self assert: rope == subrope