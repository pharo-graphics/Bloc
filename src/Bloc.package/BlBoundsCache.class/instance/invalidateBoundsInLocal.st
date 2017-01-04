invalidation
invalidateBoundsInLocal
	"Bounds properties in local coordinates change than and only than when extent changes"

	boundsInLocal := nil.
	geomBoundsInLocal := nil.
	txBounds := nil.

	self invalidateBoundsInSpace