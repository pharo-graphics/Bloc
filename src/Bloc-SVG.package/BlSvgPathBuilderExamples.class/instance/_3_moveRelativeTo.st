commands
_3_moveRelativeTo
	<gtExample>
	| aBuilder |
	
	aBuilder := self _2_lineAbsoluteTo.
	aBuilder relative.
	aBuilder moveTo: 5 negated asPoint.

	self assert: aBuilder segments size equals: 3.
	self assert: aBuilder segments first equals: (BlSvgPathMoveSegment absolute moveTo: 10@10).
	self assert: aBuilder segments second equals: (BlSvgPathLineSegment absolute lineTo: 20@20).
	self assert: aBuilder segments third equals: (BlSvgPathMoveSegment relative moveTo: (-5)@(-5)).

	^ aBuilder