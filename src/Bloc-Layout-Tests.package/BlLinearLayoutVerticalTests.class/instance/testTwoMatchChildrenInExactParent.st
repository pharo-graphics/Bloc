tests
testTwoMatchChildrenInExactParent
	"All children are distributed equally within parent's bounds"
	| childA childB |
	childA := self matchParent.
	childB := self matchParent.
	parent constraints horizontal exact: 200.
	parent constraints vertical exact: 500.

	parent addChildren: { childA . childB }.

	parent forceLayout.

	self assert: childA extent equals: 200@250.
	self assert: childA position equals: 0@0.

	self assert: childB extent equals: 200@250.
	self assert: childB position equals: 0@250.

	self assert: parent extent equals: 200@500.
	self assert: parent position equals: 0@0