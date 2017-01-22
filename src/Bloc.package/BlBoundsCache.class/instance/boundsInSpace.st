accessing
boundsInSpace
	^ boundsInSpace ifNil: [
		boundsInSpace := (self owner boundsInSpace: BlBounds new) asRectangle ]