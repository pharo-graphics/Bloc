tests
testOneChildMatchExactParentWithPaddingAndMargin
	<gtExample>
	| aChild aParent |
	
	aChild := self matchParent.
	aChild margin: (BlInsets top: 40 right: 30 bottom: 20 left: 10).
	
	aParent := self parent.

	aParent size: 400@300.
	aParent padding: (BlInsets top: 10 right: 20 bottom: 30 left: 40).
	
	aParent addChild: aChild.
	
	aParent forceLayout.

	self assert: aChild position equals: 50@50.
	self assert: aChild extent equals: 300@200.
	
	self assert: aParent position equals: 0@0.
	self assert: aParent extent equals: 400@300.
	
	^ aParent