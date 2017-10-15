*Bloc-SVG
skewX: aX Y: aY
	self invalidate.
	self transformation skewX: aX Y: aY.
	self boundsCache invalidateBoundsInSpace.
	self changed