geometry transform
rotateByDegrees: angle axis: aVector around: anOrigin
	self invalidate.
	self transform rotateByDegrees: angle axis: aVector around: anOrigin.
	self invalidate.