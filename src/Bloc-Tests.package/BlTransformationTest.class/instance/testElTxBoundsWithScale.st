tx bounds tests
testElTxBoundsWithScale
	| g n |

	n := BlElement new
		size: 100 @ 100;
		relocate: 10 @ 10;
		yourself.

	g := BlElement new
		size: 200 @ 200;
		relocate: 10 @ 10;
		addChild: n;
		yourself.

	n scaleBy: 2@2.
	g scaleBy: 2@2.

	g forceLayout.

	self assert: g position equals: (10 @ 10).
	self assert: n position equals: (10 @ 10).
	self assert: g positionInSpace equals: (10 @ 10).
	self assert: n positionInSpace equals: (30 @ 30). 
	self assert: n transformedBounds equals: ((0@0) corner: (200@200)).
	self assert: g transformedBounds equals: ((0@0) corner: (400@400)).