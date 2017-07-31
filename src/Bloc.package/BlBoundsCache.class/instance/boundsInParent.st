accessing
boundsInParent
	^ boundsInParent ifNil: [
		boundsInParent := (self owner boundsInParent: BlBounds new) asRectangle ]