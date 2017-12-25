tests - weight
testOneChildMatchExactParentWithWeightAndPadding
	<gtExample>
	| aChild aParent |
	
	aChild := self matchParent: 0.25 @ 0.5.
	aParent := self parent.

	aParent size: 400@300.
	aParent constraints padding: (BlInsets top: 10 right: 20 bottom: 30 left: 40).
	
	aParent addChild: aChild.

	aParent forceLayout.

	self assert: aChild position equals: 40@10.
	self assert: aChild extent equals: 85@130.
	
	self assert: aParent position equals: 0@0.
	self assert: aParent extent equals: 400@300.
	
	^ aParent