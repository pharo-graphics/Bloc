accessing
transformedBounds
	^ transformedBounds ifNil: [
		transformedBounds := (self owner transformedBounds: BlBounds new) asRectangle ]