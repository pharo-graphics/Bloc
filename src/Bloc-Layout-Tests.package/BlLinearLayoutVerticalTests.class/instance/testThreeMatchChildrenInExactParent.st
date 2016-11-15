tests
testThreeMatchChildrenInExactParent
	"All children are distributed equally within parent's bounds"
	| childA childB childC |
	childA := self matchParent.
	childB := self matchParent.
	childC := self matchParent.
	parent constraints horizontal exact: 200.
	parent constraints vertical exact: 600.

	parent addChildren: { childA . childB . childC }.

	parent forceLayout.

	self assert: childA extent equals: 200@200.
	self assert: childA position equals: 0@0.

	self assert: childB extent equals: 200@200.
	self assert: childB position equals: 0@200.
	
	self assert: childC extent equals: 200@200.
	self assert: childC position equals: 0@400.

	self assert: parent extent equals: 200@600.
	self assert: parent position equals: 0@0