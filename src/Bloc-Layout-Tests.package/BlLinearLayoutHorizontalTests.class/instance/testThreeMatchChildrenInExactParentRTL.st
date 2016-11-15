tests
testThreeMatchChildrenInExactParentRTL
	"All children are distributed equally within parent's bounds"
	| childA childB childC |
	childA := self matchParent.
	childB := self matchParent.
	childC := self matchParent.
	
	parent layout rightToLeft.
	parent constraints horizontal exact: 600.
	parent constraints vertical exact: 200.

	parent addChildren: { childA . childB . childC }.

	parent forceLayout.

	self assert: childC extent equals: 200@200.
	self assert: childC position equals: 0@0.

	self assert: childB extent equals: 200@200.
	self assert: childB position equals: 200@0.
	
	self assert: childA extent equals: 200@200.
	self assert: childA position equals: 400@0.

	self assert: parent extent equals: 600@200.
	self assert: parent position equals: 0@0