change reporting
invalidRect: aBlBounds from: anElement

	self makeDirty: aBlBounds.
	self requestNextPulse