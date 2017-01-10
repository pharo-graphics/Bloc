accessing
geometryBounds
	^ geometryBounds ifNil: [
		geometryBounds := (self owner geometryBounds: SpartaRectangle new) asRectangle ]