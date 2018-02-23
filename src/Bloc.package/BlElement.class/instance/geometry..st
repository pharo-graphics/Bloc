api - look
geometry: aBlGeometry

	"invalidate before changing geometry"
	self invalidate.
	geometry := aBlGeometry.
	
	"clear path cache after updating geometry path"
	self geometry releaseCache.
	boundsCache invalidateBoundsInLocal.
	
	"extent might not change, so we need to update geometry manually"
	self updateGeometry.

	"invalidate with new geometry"
	self invalidate.
	
	self requestLayout