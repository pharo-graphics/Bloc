geometry transform
rotateByRadians: angle center: aPoint
	self invalidate.
	self transform translateBy: aPoint.
	self transform rotateByRadians: angle.
	self transform translateBy: aPoint negated.
	self changed 