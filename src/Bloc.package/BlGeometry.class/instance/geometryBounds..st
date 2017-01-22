geometry bounds
geometryBounds: aBounds
	"Load my bounds in mutable rectangle.
	@see #geometryBounds for more info"
	<return: #BlBounds>

	^ aBounds
		origin: self position
		extent: self extent