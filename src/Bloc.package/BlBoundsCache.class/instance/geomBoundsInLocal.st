accessing
geomBoundsInLocal
	^ geomBoundsInLocal ifNil: [
		geomBoundsInLocal := (self owner geomBounds: SpartaRectangle new) asRectangle ]