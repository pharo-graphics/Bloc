geometry hooks
onExtentChanged
	super onExtentChanged.

	self margin: (BlInsets left: (self visualBounds right - self geometryBounds right))