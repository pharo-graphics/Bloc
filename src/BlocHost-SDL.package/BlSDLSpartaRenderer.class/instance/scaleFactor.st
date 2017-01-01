accessing
scaleFactor
	^ scaleFactor ifNil: [
		(self sdlSpace extent / self sdlSpace windowExtent) asFloatPoint ]