tx bounds tests
testElTxBoundsWithScale
	| g n |
	n := BlElement new
		extent: 100 @ 100;
		position: 10 @ 10;
		yourself.
	g := BlElement new
		extent: 200 @ 200;
		position: 10 @ 10;
		addChild: n;
		yourself.

	n scaleBy: 2@2.
	g scaleBy: 2@2.
	self assert: g position = (10 @ 10).
	self assert: n position = (10 @ 10).
	self assert: g globalPosition = (10 @ 10).
	self assert: n globalPosition = (20 @ 20).
	self assert: n transformedBounds equals: ((0@0) corner: (200@200)).
	self assert: g transformedBounds equals: ((0@0) corner: (400@400)).