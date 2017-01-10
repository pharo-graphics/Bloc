bounds tests
testElLocalAndGlobalBoundsConvertion
	| g |
	g := BlElement new
		extent: 100 @ 100;
		position: 10 @ 10;
		yourself.
	self assert: (g position = (10 @ 10)).
	self assert: g geometryBounds = (0 @ 0 corner: 100 @ 100).
	self assert: (g geometryBoundsInSpace) = (10 @ 10 corner: 110 @ 110).
	self assert: (g globalBoundsToLocal:(10 @ 10 corner: 110 @ 110)) = g geometryBounds.
	