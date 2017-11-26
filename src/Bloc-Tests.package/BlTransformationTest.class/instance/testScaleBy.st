tx bounds tests
testScaleBy
	| n |

	n := BlElement new
		size: 100 @ 100;
		relocate: 10 @ 10;
		yourself.

	n transform
		scaleBy: (2 @ 2);
		apply.

	n forceLayout.
	self assert: n position equals: (10 @ 10).
	self assert: n positionInSpace equals: (40 @ 40) negated. 
	self assert: n transformedBounds equals: ((50 @ 50) negated corner: (150@150)).
	
	n transform
		inherit;
		scaleBy: (0.5 @ 0.5);
		apply.
	n forceLayout.
	self assert: n transformedBounds equals: ((0@0) corner: (100@100)).
	
