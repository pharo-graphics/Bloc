geometry transform
translateX: xFactor Y: yFactor
	self invalidate.
	self transform translateX: xFactor y: yFactor.
	self boundsCache invalidateBoundsInSpace.
	self invalidate