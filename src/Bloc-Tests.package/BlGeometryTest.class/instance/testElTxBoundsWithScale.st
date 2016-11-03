tx bounds tests
testElTxBoundsWithScale
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
	n scaleBy:2.
	g scaleBy:2.
	self assert: g position = (10 @ 10).
	self assert: n position = (10 @ 10).
	self assert: g globalPosition = (10 @ 10).
	self assert: n globalPosition = (30 @ 30).
	self assert: n txBounds  = ((30@30) corner:(430@430)).
	self assert: g txBounds  = ((10@10) corner:(210@210)).