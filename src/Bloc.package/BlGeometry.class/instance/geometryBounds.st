geometry bounds
geometryBounds
	"Return my geometry bounds.
	This property is different from #visualBounds in the sense that I don't take stroke into account.
	Override geometryBounds: to customize computation"
	<return: #Rectangle>

	^ (self geometryBounds: BlBounds new) asRectangle