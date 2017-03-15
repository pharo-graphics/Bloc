any bounds tests
testElAnyBounds
	| g c1 c2 |
	c1 := BlElement new
		size: 200 @ 100;
		relocate: 100 @ 100;
		yourself.
	c2 := BlElement new
		size: 400 @ 300;
		relocate: 100 @ 100;
		addChild: c1;
		yourself.
	g := BlElement new
		size: 700 @ 500;
		relocate: 0 @ 0;
		addChild: c2;
		yourself.
		
	g forceLayout.

	self assert: g positionInSpace equals: (0 @ 0).
	self assert: c2 positionInSpace equals: (100 @ 100).
	self assert: c1 positionInSpace equals: (200 @ 200).
	
	self assert: g geometryBoundsInSpace equals: ((0 @ 0) corner:(700@500)).
	self assert: c2 geometryBounds equals: ((0 @ 0) corner:(400@300)).
	self assert: c1 geometryBounds equals: ((0 @ 0) corner:(200@100)).
	
	self assert: g effectBounds equals: ((0 @ 0) corner:(700@500)).
	self assert: c2 effectBounds equals: ((0 @ 0) corner:(400@300)).
	self assert: c1 effectBounds equals: ((0 @ 0) corner:(200@100)).
	
	self assert: g boundsInLocal equals: ((0 @ 0) corner:(700@500)).
	self assert: c2 boundsInLocal equals: ((0 @ 0) corner:(400@300)).
	self assert: c1 boundsInLocal equals: ((0 @ 0) corner:(200@100)).
	
	self assert: g boundsInParent equals: ((0 @ 0) corner:(700@500)).
	self assert: c2 boundsInParent equals: ((100 @ 100) corner:(500@400)).
	self assert: c1 boundsInParent equals: ((100 @ 100) corner:(300@200)).
	
	self assert: g transformedBounds equals: ((0 @ 0) corner:(700@500)).
	self assert: c2 transformedBounds equals: ((0 @ 0) corner:(400@300)).
	self assert: c1 transformedBounds equals: ((0 @ 0) corner:(200@100)).
	
	self assert: g geometryBoundsInSpace equals: ((0 @ 0) corner:(700@500)).
	self assert: c2 geometryBoundsInSpace equals: ((100 @ 100) corner:(500@400)).
	self assert: c1 geometryBoundsInSpace equals: ((200 @ 200) corner:(400@300)).
	
	