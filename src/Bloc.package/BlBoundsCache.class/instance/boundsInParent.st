accessing
boundsInParent
	self deprecated: 'Use `element bounds inParent` instead'.

	^ boundsInParent ifNil: [
		boundsInParent := (self owner boundsInParent: BlBounds new) asRectangle ]