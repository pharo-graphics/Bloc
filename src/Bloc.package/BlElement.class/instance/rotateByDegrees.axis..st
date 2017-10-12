geometry transform
rotateByDegrees: angle axis: aVector
	self invalidate.
	self transform rotateByDegrees: angle axis: aVector.
	self invalidate.