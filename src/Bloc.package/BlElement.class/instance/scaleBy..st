geometry transform
scaleBy: aFactorPoint
	self invalidate.
	self transform scaleBy: aFactorPoint.
	self boundsCache invalidateBoundsInSpace.
	self invalidate