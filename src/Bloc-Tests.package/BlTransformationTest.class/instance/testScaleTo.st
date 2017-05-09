tx bounds tests
testScaleTo
	| n |

	n := BlElement new
		size: 100 @ 100;
		relocate: 10 @ 10;
		yourself.

	n scaleTo: 2@2.
	n forceLayout.
	self assert: n transform scaleXY equals: (2.0 @ 2.0).
	self assert: n position equals: (10 @ 10).
	self assert: n positionInSpace equals: (10 @ 10). 
	self assert: n transformedBounds equals: ((0@0) corner: (200@200)).
	
	n scaleTo: 0.5@0.5.
	n forceLayout.
	self assert: n transform scaleXY equals: (0.5 @ 0.5).
	self assert: n transformedBounds equals: ((0@0) corner: (50@50)).
	
