any bounds tests
testElAnyBounds
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
	self assert: g globalPosition = (0 @ 0).
	self assert: c2 globalPosition = (100 @ 100).
	self assert: c1 globalPosition = (200 @ 200).
	
	self assert: g geometryBoundsInSpace = ((0 @ 0) corner:(700@500)).
	self assert: c2 geometryBounds = ((0 @ 0) corner:(400@300)).
	self assert: c1 geometryBounds = ((0 @ 0) corner:(200@100)).
	
	self assert: g fxBounds = ((0 @ 0) corner:(700@500)).
	self assert: c2 fxBounds = ((0 @ 0) corner:(400@300)).
	self assert: c1 fxBounds = ((0 @ 0) corner:(200@100)).
	
	self assert: g boundsInLocal = ((0 @ 0) corner:(700@500)).
	self assert: c2 boundsInLocal = ((0 @ 0) corner:(400@300)).
	self assert: c1 boundsInLocal = ((0 @ 0) corner:(200@100)).
	
	self assert: g boundsInParent = ((0 @ 0) corner:(700@500)).
	self assert: c2 boundsInParent = ((100 @ 100) corner:(500@400)).
	self assert: c1 boundsInParent = ((100 @ 100) corner:(300@200)).
	
	self assert: g txBounds = ((0 @ 0) corner:(700@500)).
	self assert: c2 txBounds = ((0 @ 0) corner:(400@300)).
	self assert: c1 txBounds = ((0 @ 0) corner:(200@100)).
	
	self assert: g geometryBoundsInSpace = ((0 @ 0) corner:(700@500)).
	self assert: c2 geometryBoundsInSpace = ((100 @ 100) corner:(500@400)).
	self assert: c1 geometryBoundsInSpace = ((200 @ 200) corner:(400@300)).
	
	