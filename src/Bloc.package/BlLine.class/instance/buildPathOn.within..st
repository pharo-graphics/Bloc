path building
buildPathOn: aPathBuilder within: aBounds
	| newPoints |
	newPoints := self pointsWithin: aBounds.
	aPathBuilder
		absolute;
		moveTo: newPoints origin;
		lineTo: newPoints corner