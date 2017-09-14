*Bloc-SVG
transformWithMatrix2D: aBlMatrix2D
	self invalidate.
	self transform multiplyByMatrix2D: aBlMatrix2D.
	self boundsCache invalidateBoundsInSpace.
	self changed