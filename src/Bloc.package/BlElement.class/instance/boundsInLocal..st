geometry bounds
boundsInLocal: aSpartaRectangle
	"I load my local bounds in a given mutable rectangle and return provided one.
	I do not rely on cache and always provide with actual bounds.
	I am a part of internal api, use me with caution"
	<return: #SpartaRectangle>
	
	^ (self geomBounds: aSpartaRectangle)
		merge: self fxBounds;
		yourself