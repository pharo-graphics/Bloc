tests
testTwoMatchChildrenInExactParent
	"All children are distributed equally within parent's bounds"
	| childA childB |
	childA := self matchParent.
	childB := self matchParent.
	parent constraints horizontal exact: 500.
	parent constraints vertical exact: 200.

	parent addChildren: { childA . childB }.

	parent forceLayout.

	self assert: childA extent equals: 250@200.
	self assert: childA position equals: 0@0.

	self assert: childB extent equals: 250@200.
	self assert: childB position equals: 250@0.

	self assert: parent extent equals: 500@200.
	self assert: parent position equals: 0@0