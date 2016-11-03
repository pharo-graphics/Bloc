geometry transform
scaleX: factor
	self invalidate.
	self transform scaleX: factor Y: 1.
	self changed 