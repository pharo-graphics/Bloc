hooks - geometry
onExtentChanged
	"Is sent when my extent changed"

	"extent changed => invalidate cached local bounds"
	boundsCache invalidateBoundsInLocal.
	"extent changed => path also"
	self updateGeometry.
	"background might want to resize itself"
	self updateBackground.
	"clear path cache after updating geometry path"
	self geometry releaseCache.
	
	self transformation invalidateMatrix.

	self invalidate.
	self notifyExtentChanged