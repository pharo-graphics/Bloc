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

	n transform
		scaleBy: 2@2;
		apply.
	g transform
		scaleBy: 2@2;
		apply.

	g forceLayout.

	self assert: g position equals: (10 @ 10).
	self assert: n position equals: (10 @ 10).
	self assert: g positionInSpace equals: (90 @ 90) negated.
	self assert: n positionInSpace equals: (170 @ 170) negated. 
	self assert: n transformedBounds equals: ((50@50) negated extent: (200@200)).
	self assert: g transformedBounds equals: ((100@100) negated extent: (400@400)).