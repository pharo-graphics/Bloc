geometry bounds
boundsInSpace: aSpartaRectangle
	"I load my bounds in space in a given mutable rectangle and return provided one.
	I do not rely on cache and always provide with actual bounds.
	I am a part of internal api, use me with caution"
	<return: #SpartaRectangle>

	self boundsInLocal: aSpartaRectangle.
	self localBoundsToGlobal: aSpartaRectangle.
	^ aSpartaRectangle