transformations
transformation: anElementTransformation

	self invalidate.
	transformation := anElementTransformation owner: self.
	self boundsCache invalidateBoundsInSpace.
	self invalidate