tests
testOneChildMatchOneExactInFitParent
	"All children are distributed equally within parent's bounds"
	| childA childB |
	childA := self exact: 200@300.
	childB := self exactHeight: 200.
	childB constraints horizontal matchParent.

	parent constraints horizontal fitContent.
	parent constraints vertical fitContent.

	parent addChildren: { childA . childB }.

	parent forceLayout.

	self assert: childA extent equals: 200@300.
	self assert: childA position equals: 0@0.

	self assert: childB extent equals: 200@200.
	self assert: childB position equals: 0@300.

	self assert: parent extent equals: 200@500.
	self assert: parent position equals: 0@0