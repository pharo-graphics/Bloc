geometry bounds
geometryBounds: aSpartaRectangle
	"Load my bounds in mutable rectangle.
	@see #geometryBounds for more info"
	<return: #SpartaRectangle>

	^ aSpartaRectangle
		origin: self position
		extent: self extent