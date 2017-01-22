tx bounds tests
testElTxBounds
	| g n |
	n := BlElement new
		extent: 100 @ 100;
		position: 10 @ 10;
		yourself.
	g := BlElement new
		extent: 100 @ 100;
		position: 10 @ 10;
		addChild: n;
		yourself.
	self assert: g position = (10 @ 10).
	self assert: n position = (10 @ 10).
	self assert: g globalPosition = (10 @ 10).
	self assert: n globalPosition = (20 @ 20).
	self assert: n transformedBounds  = ((0@0) corner:(100@100)).
	self assert: g transformedBounds  = ((0@0) corner:(100@100)).