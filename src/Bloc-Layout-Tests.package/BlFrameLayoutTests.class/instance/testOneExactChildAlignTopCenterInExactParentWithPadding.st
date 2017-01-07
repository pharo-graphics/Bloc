tests
testOneExactChildAlignTopCenterInExactParentWithPadding
	| child |
	child := self exact: 100@50.
	child constraints frame horizontal alignCenter.
	child constraints frame vertical alignTop.
	parent constraints padding: (BlInsets top: 10 right: 20 bottom: 30 left: 40).

	parent size: 400@300.
	
	parent addChild: child.

	parent forceLayout.

	self assert: child position equals: 160@10.
	self assert: child extent equals: 100@50.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.