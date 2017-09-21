geometry hooks
onExtentChanged
	"Is sent when my extent changed"

	"extent changed => invalidate cached local bounds"
	boundsCache invalidateBoundsInLocal.
	"extent changed => path also"
	self updatePath.
	"clear path cache after updating geometry path"
	pathCache releaseCache.

	self notifyExtentChanged