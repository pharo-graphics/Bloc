geometry
geometryBounds: aBounds
	^ (aBounds
		origin: (self from min: self to)
		extent: (self from max: self to)) expandBy: self width * 2 / 2 sqrt