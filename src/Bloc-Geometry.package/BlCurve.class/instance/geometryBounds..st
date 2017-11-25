geometry bounds
geometryBounds: aBounds
	^ (aBounds rectangle: (Rectangle encompassing: self controlPoints))