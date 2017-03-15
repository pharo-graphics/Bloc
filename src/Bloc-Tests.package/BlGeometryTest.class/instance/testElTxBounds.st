tx bounds tests
testElTxBounds
	| g n |
	n := BlElement new
		size: 100 @ 100;
		relocate: 10 @ 10;
		yourself.
	g := BlElement new
		size: 100 @ 100;
		relocate: 10 @ 10;
		addChild: n;
		yourself.
		
	g forceLayout.

	self assert: g position = (10 @ 10).
	self assert: n position = (10 @ 10).
	self assert: g positionInSpace = (10 @ 10).
	self assert: n positionInSpace = (20 @ 20).
	self assert: n transformedBounds  = ((0@0) corner:(100@100)).
	self assert: g transformedBounds  = ((0@0) corner:(100@100)).