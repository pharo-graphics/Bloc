geometry
geometryBounds: aBounds
	^ (aBounds rectangle: (Rectangle encompassing: { self from . self to}))