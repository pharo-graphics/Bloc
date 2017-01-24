geometry transform
translateBy: aDelta
	"Apply a translation by the given delta.
	Note: aDelta may be a Point, a BlPoint3D, aNumber or a BlockClosure that returns
	one of the supported types."

	self invalidate.
	self transform translateBy: aDelta.
	self boundsCache invalidateBoundsInSpace.
	self invalidate