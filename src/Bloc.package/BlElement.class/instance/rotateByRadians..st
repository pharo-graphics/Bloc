geometry transform
rotateByRadians: angle
	self invalidate.
	self transform rotateByRadians: angle.
	self changed 