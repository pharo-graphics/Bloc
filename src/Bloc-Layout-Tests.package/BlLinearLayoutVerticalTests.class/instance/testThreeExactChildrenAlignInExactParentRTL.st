tests
testThreeExactChildrenAlignInExactParentRTL
	| childA childB childC |
	childA := self exact: 100@100.
	childB := self exact: 200@100.
	childC := self exact: 50@100.
	
	childA constraints linear horizontal alignLeft.
	childB constraints linear horizontal alignCenter.
	childC constraints linear horizontal alignRight.
	
	parent layout rightToLeft.
	parent constraints horizontal exact: 500.
	parent constraints vertical exact: 600.
	
	parent addChildren: { childA . childB . childC }.

	parent forceLayout.

	self assert: childA extent equals: 100@100.
	self assert: childA position equals: 400@0.

	self assert: childB extent equals: 200@100.
	self assert: childB position equals: 150@100.
	
	self assert: childC extent equals: 50@100.
	self assert: childC position equals: 0@200.

	self assert: parent extent equals: 500@600.
	self assert: parent position equals: 0@0