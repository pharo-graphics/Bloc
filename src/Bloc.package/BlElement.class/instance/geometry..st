accessing
geometry: anObject
	geometry := anObject.
	pathCache releaseCache.
	self invalidate
