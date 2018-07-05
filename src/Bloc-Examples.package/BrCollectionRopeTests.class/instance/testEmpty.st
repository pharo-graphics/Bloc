tests
testEmpty
	| rope |
	
	rope := BlCollectionRope collection: ''.
	
	self assert: rope size equals: 0.
	self assert: rope isEmpty