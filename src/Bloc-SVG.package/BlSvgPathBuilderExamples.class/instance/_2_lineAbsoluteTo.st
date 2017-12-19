commands
_2_lineAbsoluteTo
	<gtExample>
	| aBuilder |
	
	aBuilder := self _1_moveAbsoluteTo.
	aBuilder absolute.
	aBuilder lineTo: 20@20.

	self assert: aBuilder segments size equals: 2.
	self assert: aBuilder segments first equals: (BlSvgPathMoveSegment absolute moveTo: 10@10).
	self assert: aBuilder segments second equals: (BlSvgPathLineSegment absolute lineTo: 20@20).

	^ aBuilder