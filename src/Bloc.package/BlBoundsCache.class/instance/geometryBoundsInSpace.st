accessing
geometryBoundsInSpace
	^ geometryBoundsInSpace
		ifNil: [ geometryBoundsInSpace := (self owner geometryBoundsInSpace: SpartaRectangle new) asRectangle ]