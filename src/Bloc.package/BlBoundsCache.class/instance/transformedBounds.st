accessing
transformedBounds
	^ transformedBounds ifNil: [
		transformedBounds := (self owner transformedBounds: SpartaRectangle new) asRectangle ]