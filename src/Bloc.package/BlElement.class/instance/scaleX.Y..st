geometry transform
scaleX: fx Y: fy
	self invalidate.
	self transform scaleBy: (BlVector x: fx y: fy z: 1).
	self boundsCache invalidateBoundsInSpace.
	self invalidate