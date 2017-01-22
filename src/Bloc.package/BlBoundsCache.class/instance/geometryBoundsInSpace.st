accessing
geometryBoundsInSpace
	^ geometryBoundsInSpace
		ifNil: [ geometryBoundsInSpace := (self owner geometryBoundsInSpace: BlBounds new) asRectangle ]