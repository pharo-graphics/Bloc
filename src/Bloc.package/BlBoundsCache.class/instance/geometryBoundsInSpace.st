accessing
geometryBoundsInSpace
	^ geometryBoundsInSpace
		ifNil: [ geometryBoundsInSpace := (self owner geomBoundsInSpace: SpartaRectangle new) asRectangle ]