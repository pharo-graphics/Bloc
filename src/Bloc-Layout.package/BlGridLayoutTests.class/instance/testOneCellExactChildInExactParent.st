tests - layout
testOneCellExactChildInExactParent
	| child |
	
	child := self exact: 200@300.
	parent constraints horizontal exact: 300.
	parent constraints vertical exact: 400.

	parent addChild: child.
	parent forceLayout.

	self assert: child extent equals: 200@300.
	self assert: child position equals: 0@0.
	
	self assert: parent extent equals: 300@400.
	self assert: parent position equals: 0@0.