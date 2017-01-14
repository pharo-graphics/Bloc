geometry bounds
geometryBounds: aSpartaRectangle
	"I load my geometry bounds in a given mutable rectangle and return provided one.
	By default it is nothing else than a rectangle with origin point set to
	geometry's position and with extent equal to my geometry's extent.
	GEOMETRY BOUNDS PROPERTY DOES NOT TAKE EFFECT OR BORDER OR BACKGROUND INTO ACCOUNT
	I am a part of internal api, use me with caution"
	<return: #SpartaRectangle>

	^ self geometry geometryBounds: aSpartaRectangle