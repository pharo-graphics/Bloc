geometry transform
scaleTo: aFactorPoint
	self invalidate.
	self transform scaleTo: aFactorPoint.
	self boundsCache invalidateBoundsInSpace.
	self invalidate