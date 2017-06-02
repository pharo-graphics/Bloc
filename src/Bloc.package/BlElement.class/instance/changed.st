change reporting
changed
	self invalidate.
	boundsCache invalidateBoundsInSpace.
	self requestParentLayout.
	pathCache releaseCache.
	self invalidate