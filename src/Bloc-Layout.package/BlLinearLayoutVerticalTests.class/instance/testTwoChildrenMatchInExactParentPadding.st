tests
testTwoChildrenMatchInExactParentPadding
	"All children are distributed equally within parent's bounds"
	| childA childB |
	childA := self matchParent.
	childB := self matchParent.

	parent constraints horizontal exact: 600.
	parent constraints vertical exact: 400.
	parent constraints padding: (BlInsets all: 20).

	parent addChildren: { childA . childB }.

	parent forceLayout.

	self assert: childA extent equals: 560@180.
	self assert: childA position equals: 20@20.
	
	self assert: childB extent equals: 560@180.
	self assert: childB position equals: 20@200.

	self assert: parent extent equals: 600@400.
	self assert: parent position equals: 0@0