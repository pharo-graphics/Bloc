private - accessing
scaleFactor
	^ scaleFactor ifNil: [ self hostSpace scaleFactor ]