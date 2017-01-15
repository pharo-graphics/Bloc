accessing
scaleFactor
	^ scaleFactor ifNil: [
		(sdlSpace drawableExtent / sdlSpace windowExtent) asFloatPoint ]