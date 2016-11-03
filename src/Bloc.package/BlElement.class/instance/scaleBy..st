geometry transform
scaleBy: factor
	self invalidate.
	self transform scaleBy: factor.
	self changed 