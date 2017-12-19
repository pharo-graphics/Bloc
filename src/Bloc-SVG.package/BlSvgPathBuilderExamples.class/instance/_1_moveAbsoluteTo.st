commands
_1_moveAbsoluteTo
	<gtExample>
	| aBuilder |

	aBuilder := self pathBuilder.
	aBuilder absolute.
	aBuilder moveTo: 10@10.

	self assert: aBuilder segments size equals: 1.
	self assert: aBuilder segments first equals: (BlSvgPathMoveSegment absolute moveTo: 10@10).

	^ aBuilder