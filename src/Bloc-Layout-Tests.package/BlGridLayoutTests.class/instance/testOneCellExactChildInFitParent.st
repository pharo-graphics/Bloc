tests - layout
testOneCellExactChildInFitParent
	| child |
	
	child := self exact: 200@300.
	parent constraints horizontal fitContent.
	parent constraints vertical fitContent.

	parent addChild: child.
	parent forceLayout.

	self assert: child extent equals: 200@300.
	self assert: child position equals: 0@0.
	
	self assert: parent extent equals: 200@300.
	self assert: parent position equals: 0@0.