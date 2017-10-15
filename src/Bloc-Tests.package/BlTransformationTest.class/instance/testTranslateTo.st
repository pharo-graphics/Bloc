tx bounds tests
testTranslateTo
	| n |

	n := BlElement new
		size: 100 @ 100;
		relocate: 10 @ 10;
		yourself.

	n transform
		translateBy: (10, 10);
		apply.
		
	n forceLayout.
	self assert: n position equals: (10 @ 10).
	self assert: n positionInSpace equals: (20 @ 20). 
	self assert: n transformedBounds equals: ((10@10) corner: (110@110)).
	
	n transform
		translateBy: (30, 30);
		apply.
	n forceLayout.
	self assert: n position equals: (10 @ 10).
	self assert: n positionInSpace equals: (40 @ 40). 
	self assert: n transformedBounds equals: ((30@30) corner: (130@130))