anchor - geometry
decoratedToPosition
	^ self toPosition - ((self toHeadLength - 1) * (self normalizeDirection: self toDirection)) asPoint