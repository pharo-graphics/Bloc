contains tests
test3ElContainsPoint
	| g c1 c2 |

	c1 := BlElement new
		size: 200 @ 100;
		relocate: 100 @ 100;
		background: Color yellow;
		yourself.

	c2 := BlElement new
		size: 400 @ 300;
		relocate: 100 @ 100;
		background: Color red;
		addChild: c1;
		yourself.

	g := BlElement new
		size: 700 @ 500;
		relocate: 0 @ 0;
		background: Color blue;
		addChild: c2;
		yourself.

	g forceLayout.

	self assert: (c1 containsGlobalPoint: (250@250)).
	self assert: (c2 containsGlobalPoint: (250@250)).
	self assert: (g containsGlobalPoint: (250@250)).

	self assert: (c1 containsPoint: (50@50))