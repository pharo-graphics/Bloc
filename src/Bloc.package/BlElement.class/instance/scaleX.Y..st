geometry transform
scaleX: fx Y: fy
	self invalidate.
	self transform scaleX: fx Y: fy.
	self boundsCache invalidateBoundsInSpace.
	self invalidate