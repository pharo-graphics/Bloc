geometry bounds
boundsInLocal: aSpartaRectangle
	"I load my local bounds in a given mutable rectangle and return provided one.
	I do not rely on cache and always provide with actual bounds.
	Local Bounds is nothing else as a rectangle with origin point set to 0@0
	and with extent equal to my pure extent.
	Local Bounds property does not take any effects into account.
	I am a part of internal api, use me with caution"
	<return: #SpartaRectangle>

	^ aSpartaRectangle
		left: 0
		top: 0
		corner: self extent;
		yourself