geometry transform
scaleY: factor
	self invalidate.
	self transform scaleX: 1 Y: factor.
	self changed 