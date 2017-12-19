commands
_4_lineRelativeTo
	<gtExample>
	| aBuilder |
	
	aBuilder := self _3_moveRelativeTo.
	aBuilder relative.
	aBuilder lineTo: 10@25.

	self assert: aBuilder segments size equals: 4.
	self assert: aBuilder segments first equals: (BlSvgPathMoveSegment absolute moveTo: 10@10).
	self assert: aBuilder segments second equals: (BlSvgPathLineSegment absolute lineTo: 20@20).
	self assert: aBuilder segments third equals: (BlSvgPathMoveSegment relative moveTo: (-5)@(-5)).
	self assert: aBuilder segments fourth equals: (BlSvgPathLineSegment relative lineTo: 10@25).

	^ aBuilder