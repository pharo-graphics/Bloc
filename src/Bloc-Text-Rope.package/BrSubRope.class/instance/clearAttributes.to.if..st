rope - accessing
clearAttributes: aStart to: anEnd if: aBlock
	| anClearedRope |
	self assertAccessInsert: aStart.
	self assertAccessInsert: anEnd.

	anClearedRope := self rope clearAttributes: aStart + offset to: anEnd + offset if: aBlock.
	^ anClearedRope from: offset + 1 to: offset + 1 + length