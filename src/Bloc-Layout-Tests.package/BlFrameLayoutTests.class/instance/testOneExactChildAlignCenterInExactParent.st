tests
testOneExactChildAlignCenterInExactParent
	| child |
	child := self exact: 100@50.
	child constraints frame horizontal alignCenter.
	child constraints frame vertical alignCenter.

	parent extent: 400@300.
	
	parent addChild: child.

	parent forceLayout.

	self assert: child position equals: 150@125.
	self assert: child extent equals: 100@50.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.