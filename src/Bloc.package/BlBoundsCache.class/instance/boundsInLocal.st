accessing
boundsInLocal
	^ boundsInLocal ifNil: [
		boundsInLocal := (self owner boundsInLocal: BlBounds new) asRectangle ]