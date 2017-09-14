*Bloc-SVG
skewBy: aPoint
	self invalidate.
	self transform skewBy: aPoint.
	self boundsCache invalidateBoundsInSpace.
	self changed