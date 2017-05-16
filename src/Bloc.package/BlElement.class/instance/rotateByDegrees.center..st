geometry transform
rotateByDegrees: angle center: aPoint
	self invalidate.
	self transform rotateByDegrees: angle axis: aPoint.
	self changed 