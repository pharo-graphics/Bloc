geometry transform
translateTo: aPoint
	"Define the coordinates of the translation using the given point.
	Note: aPoint may be a Point, a BlPoint3D or a BlockClosure that returns 
	one of the supported types."

	self invalidate.
	self transform translateTo: aPoint.
	self boundsCache invalidateBoundsInSpace.
	self invalidate