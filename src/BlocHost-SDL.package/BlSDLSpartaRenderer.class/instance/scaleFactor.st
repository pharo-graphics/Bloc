accessing
scaleFactor
	^ scaleFactor ifNil: [
		(self sdlSpace rendererExtent / self sdlSpace windowExtent) asFloatPoint ]