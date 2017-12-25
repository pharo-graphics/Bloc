tests - weight
testOneChildMatchExactParentWithWeight
	<gtExample>
	| aParent aChild |
	
	aParent := self parent size: 400@300.
	aChild := self matchParent: 0.5 @ 0.4.
	aParent addChild: aChild.
	aParent forceLayout.
	
	self assert: aChild position equals: 0@0.
	self assert: aChild extent equals: 200@120.
	
	self assert: aParent position equals: 0@0.
	self assert: aParent extent equals: 400@300.
	
	^ aParent