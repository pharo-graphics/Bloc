geometry bounds
geometryBounds: aSpartaRectangle
	"I load my geometry bounds in a given mutable rectangle and return provided one.
	Geometry Bounds by default is nothing else than a rectangle with origin point set to 0@0
	and with extent equal to my pure extent.
	Geometry Bounds property does not take any effects into account.
	I am a part of internal api, use me with caution"
	<return: #SpartaRectangle>

	^ (self boundsInLocal: aSpartaRectangle) expandBy: self border outsets