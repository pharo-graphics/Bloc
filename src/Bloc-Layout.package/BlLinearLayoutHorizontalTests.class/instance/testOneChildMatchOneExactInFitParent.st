tests
testOneChildMatchOneExactInFitParent
	"All children are distributed equally within parent's bounds"
	| childA childB |
	childA := self exact: 300@200.
	childB := self exactWidth: 200.
	childB constraints vertical matchParent.

	parent constraints horizontal fitContent.
	parent constraints vertical fitContent.

	parent addChildren: { childA . childB }.

	parent forceLayout.

	self assert: childA extent equals: 300@200.
	self assert: childA position equals: 0@0.

	self assert: childB extent equals: 200@200.
	self assert: childB position equals: 300@0.

	self assert: parent extent equals: 500@200.
	self assert: parent position equals: 0@0