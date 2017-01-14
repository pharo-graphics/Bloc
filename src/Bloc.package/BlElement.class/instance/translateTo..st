geometry transform
translateTo: factor
	self invalidate.
	self transform translation:factor.
	self boundsCache invalidateBoundsInSpace.
	self invalidate