contains tests
test3ElContainsPoint
	| g c1 c2 |
	c1 := BlElement new
		extent: 200 @ 100;
		position: 100 @ 100;
		yourself.
	c2 := BlElement new
		extent: 400 @ 300;
		position: 100 @ 100;
		addChild: c1;
		yourself.
	g := BlElement new
		extent: 700 @ 500;
		position: 0 @ 0;
		addChild: c2;
		yourself.

	self assert: (c1 containsGlobalPoint: (250@250)).
	self assert: (c2 containsGlobalPoint: (250@250)).
	self assert: (g containsGlobalPoint: (250@250)).
	
	self assert: (c1 containsPoint: (50@50)).
	
	