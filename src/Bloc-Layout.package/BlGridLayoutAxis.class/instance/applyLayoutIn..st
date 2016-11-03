measure
applyLayoutIn: size

	self parentConstraintsMin: size max: size.
	self locations