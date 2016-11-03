geometry transform
scaleTo: factor
	self invalidate.
	self transform scale: factor.
	self changed