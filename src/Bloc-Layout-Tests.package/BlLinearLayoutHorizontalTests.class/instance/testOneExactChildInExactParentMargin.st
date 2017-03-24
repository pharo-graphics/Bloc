tests
testOneExactChildInExactParentMargin
	"All children are distributed equally within parent's bounds"
	| childA |
	childA := self exact: 20@20.
	childA margin: (BlInsets top: 15 right: 0 bottom: 0 left: 10).
	
	parent constraints horizontal exact: 50.
	parent constraints vertical exact: 50.

	parent addChildren: { childA }.

	parent forceLayout.

	self assert: childA extent equals: 20@20.
	self assert: childA position equals: 10@15.

	self assert: parent extent equals: 50@50.
	self assert: parent position equals: 0@0