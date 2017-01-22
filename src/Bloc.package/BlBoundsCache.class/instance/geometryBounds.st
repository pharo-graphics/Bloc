accessing
geometryBounds
	^ geometryBounds ifNil: [
		geometryBounds := (self owner geometryBounds: BlBounds new) asRectangle ]