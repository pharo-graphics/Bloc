tests
testEmpty
	| rope |
	
	rope := BrCollectionRope collection: ''.
	
	self assert: rope size equals: 0.
	self assert: rope isEmpty