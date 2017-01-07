tests
testOneChildMatchExactParent
	| child |
	child := self matchParent.
	parent size: 400@300.
	
	parent addChild: child.
	
	parent forceLayout.
	
	self assert: child position equals: 0@0.
	self assert: child extent equals: 400@300.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.