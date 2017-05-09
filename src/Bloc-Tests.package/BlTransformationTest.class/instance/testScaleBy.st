tx bounds tests
testScaleBy
	| n |

	n := BlElement new
		size: 100 @ 100;
		relocate: 10 @ 10;
		yourself.

	n scaleBy: 2@2.
	n forceLayout.
	self assert: n transform scaleXY equals: (2.0 @ 2.0).
	self assert: n position equals: (10 @ 10).
	self assert: n positionInSpace equals: (10 @ 10). 
	self assert: n transformedBounds equals: ((0@0) corner: (200@200)).
	
	n scaleBy: 0.5@0.5.
	n forceLayout.
	self assert: n transform scaleXY equals: (1.0 @ 1.0).
	self assert: n transformedBounds equals: ((0@0) corner: (100@100)).
	
