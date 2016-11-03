change reporting
changed
	self invalidate.
	boundsCache invalidateBoundsInSpace.
	self geomBoundsProperty invalidate.
	self requestParentLayout.
	self updatePath.
	pathCache releaseCache.
	self invalidate