bounds conversion
boundsInLocal: aBlBounds
	"I load my local bounds in the given mutable bounds and return it.
	I do not rely on cache and always provide actual bounds.
	Local Bounds is nothing else than the bounds with origin point set to 0@0
	and with extent equal to my pure extent.
	Local Bounds property does not take effect or border into account.
	I am a part of internal api, use me with caution"
	<return: #BlBounds>

	^ aBlBounds
		left: 0
		top: 0
		corner: self extent;
		yourself