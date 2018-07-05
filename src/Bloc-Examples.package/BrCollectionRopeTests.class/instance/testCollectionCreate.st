tests
testCollectionCreate
	| rope |
	
	rope := BlCollectionRope collection: 'Haba'.
	
	self assert: rope size equals: 4.
	self assert: rope collection equals: 'Haba'.
	self assert: rope isLeaf