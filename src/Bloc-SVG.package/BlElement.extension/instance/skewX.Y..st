*Bloc-SVG
skewX: aX Y: aY
	self invalidate.
	self transform skewX: aX Y: aY.
	self boundsCache invalidateBoundsInSpace.
	self changed