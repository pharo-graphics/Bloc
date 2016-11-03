*Bloc-Sparta
buildPathOnSpartaCanvas: aCanvas within: aBounds
	| pathBuilder newPoints |
	newPoints := self pointsWithin: aBounds.
	pathBuilder := aCanvas path
		absolute;
		absolute;
		moveTo: newPoints origin;
		lineTo: newPoints corner.
	pathBuilder close.
	^ pathBuilder finish