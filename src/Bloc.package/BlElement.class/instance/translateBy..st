geometry transform
translateBy: factor
	self invalidate.
	self transform translateBy: factor.
	self boundsCache invalidateBoundsInSpace.
	self invalidate