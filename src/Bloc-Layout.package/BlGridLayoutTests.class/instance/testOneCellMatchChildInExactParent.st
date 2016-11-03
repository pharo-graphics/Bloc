tests - layout
testOneCellMatchChildInExactParent
	| child |

	child := self matchParent.
	parent constraints horizontal exact: 400.
	parent constraints vertical exact: 300.

	parent addChild: child.
	parent forceLayout.

	self assert: child extent equals: 400@300.
	self assert: child position equals: 0@0.
	
	self assert: parent extent equals: 400@300.
	self assert: parent position equals: 0@0.