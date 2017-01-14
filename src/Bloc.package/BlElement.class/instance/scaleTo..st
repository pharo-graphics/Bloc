geometry transform
scaleTo: aFactorPoint
	self invalidate.
	self transform scale: aFactorPoint.
	self boundsCache invalidateBoundsInSpace.
	self invalidate