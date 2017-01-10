invalidation
invalidateBoundsInLocal
	"Bounds properties in local coordinates change than and only than when extent changes"

	boundsInLocal := nil.
	geometryBounds := nil.
	transformedBounds := nil.

	self invalidateBoundsInSpace