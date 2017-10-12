geometry transform
rotateByDegrees: angle axis: aVector origin: anOrigin
	self invalidate.
	self transform rotateByDegrees: angle axis: aVector origin: anOrigin.
	self invalidate.