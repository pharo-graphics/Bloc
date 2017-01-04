change reporting
changed
	self invalidate.
	boundsCache invalidateBoundsInSpace.
	self requestParentLayout.
	self updatePath.
	pathCache releaseCache.
	self invalidate