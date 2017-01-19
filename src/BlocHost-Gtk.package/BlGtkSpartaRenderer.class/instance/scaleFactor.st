updating screen
scaleFactor
	^ scaleFactor ifNil: [ self hostSpace scaleFactor ]