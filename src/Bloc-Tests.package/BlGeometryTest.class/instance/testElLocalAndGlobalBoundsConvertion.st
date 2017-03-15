bounds tests
testElLocalAndGlobalBoundsConvertion
	| g |
	g := BlElement new
		size: 100 @ 100;
		relocate: 10 @ 10;
		yourself.

	g forceLayout.

	self assert: g position equals: (10 @ 10).
	self assert: g geometryBounds equals: (0 @ 0 corner: 100 @ 100).
	self assert: g geometryBoundsInSpace equals: (10 @ 10 corner: 110 @ 110).
	
	self assert: (g globalBoundsToLocal: (BlBounds fromRectangle:(10 @ 10 corner: 110 @ 110))) asRectangle equals: g geometryBounds.
	"is the same as"
	self assert: (g localBoundsToGlobal: (BlBounds fromRectangle: g geometryBounds)) asRectangle equals: (10 @ 10 corner: 110 @ 110)