geometry bounds
geometryBounds: aBounds
	"Load my bounds in mutable rectangle.
	@see #geometryBounds for more info"
	<return: #BlBounds>

	^ aBounds
		origin: self origin
		extent: (self radius * 2) asPoint