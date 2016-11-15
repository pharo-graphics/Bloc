tests
testOneChildMatchInExactParentPadding
	"All children are distributed equally within parent's bounds"
	| childA |
	childA := self matchParent.

	parent constraints horizontal exact: 400.
	parent constraints vertical exact: 600.
	parent constraints padding: (BlInsets all: 20).

	parent addChildren: { childA }.

	parent forceLayout.

	self assert: childA extent equals: 360@560.
	self assert: childA position equals: 20@20.

	self assert: parent extent equals: 400@600.
	self assert: parent position equals: 0@0