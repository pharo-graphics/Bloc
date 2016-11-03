geometry transform
translateX: xFactor Y: yFactor
	self invalidate.
	self transform translateX: xFactor y: yFactor.
	self notifyPositionChanged.
	self changed