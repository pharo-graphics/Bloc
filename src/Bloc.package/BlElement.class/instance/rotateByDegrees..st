geometry transform
rotateByDegrees: angle
	self invalidate.
	self transform rotateByDegrees: angle.
	self changed 