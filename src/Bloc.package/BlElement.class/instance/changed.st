updating
changed
	self deprecated: 'Never use me, instead invalidate only what is needed'.

	self invalidate.
	boundsCache invalidateBoundsInLocal.
	self requestLayout.
	self geometry releaseCache.
	self invalidate