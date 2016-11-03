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
	self assert: n txBounds  = ((20@20) corner:(120@120)).
	self assert: g txBounds  = ((10@10) corner:(110@110)).