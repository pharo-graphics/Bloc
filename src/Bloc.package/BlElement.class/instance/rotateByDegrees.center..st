geometry transform
rotateByDegrees: angle center: aPoint
	self invalidate.
	self transform translateBy: aPoint.
	self transform rotateByDegrees: angle.
	self transform translateBy: aPoint negated.
	self changed 