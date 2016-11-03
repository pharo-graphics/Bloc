geometry transform
translateBy: factor
	self invalidate.
	self transform translateBy: factor.
	self notifyPositionChanged.
	self changed