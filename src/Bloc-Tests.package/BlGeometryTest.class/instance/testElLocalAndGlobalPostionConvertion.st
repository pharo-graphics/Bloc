position tests
testElLocalAndGlobalPostionConvertion
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

	self assert: g position equals: (10 @ 10).
	self assert: n position equals: (10 @ 10).
	self assert: g positionInSpace equals: (10 @ 10).
	self assert: n positionInSpace equals: (20 @ 20).
	self assert: (n parentPointToLocal: n position) equals: (0@0).