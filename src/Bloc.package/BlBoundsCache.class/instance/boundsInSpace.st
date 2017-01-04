accessing
boundsInSpace
	^ boundsInSpace ifNil: [
		boundsInSpace := (self owner boundsInSpace: SpartaRectangle new) asRectangle ]