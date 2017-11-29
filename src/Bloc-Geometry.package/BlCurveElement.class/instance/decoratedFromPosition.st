anchor - geometry
decoratedFromPosition
	^ self fromPosition - ((self fromHeadLength - 1) * (self normalizeDirection: self fromDirection)) asPoint