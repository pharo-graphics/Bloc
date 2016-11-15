tests
testOneChildMatchExactParentWithPadding
	| child |
	child := self matchParent.
	parent extent: 400@300.
	parent constraints padding: (BlInsets top: 10 right: 20 bottom: 30 left: 40).
	
	parent addChild: child.
	
	parent forceLayout.

	self assert: child position equals: 40@10.
	self assert: child extent equals: 340@260.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.