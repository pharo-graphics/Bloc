*Bloc-SVG
transformWithMatrix2D: aBlMatrix2D
	self invalidate.
	self transformation multiplyByMatrix2D: aBlMatrix2D.
	self boundsCache invalidateBoundsInSpace.
	self changed