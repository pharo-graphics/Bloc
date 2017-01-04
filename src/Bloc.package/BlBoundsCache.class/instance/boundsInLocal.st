accessing
boundsInLocal
	^ boundsInLocal ifNil: [
		boundsInLocal := (self owner boundsInLocal: SpartaRectangle new) asRectangle ]