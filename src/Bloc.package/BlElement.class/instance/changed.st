updating
changed
	self invalidate.
	boundsCache invalidateBoundsInLocal.
	self requestLayout.
	pathCache releaseCache.
	self invalidate