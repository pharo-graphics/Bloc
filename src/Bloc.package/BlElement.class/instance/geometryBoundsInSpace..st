geometry bounds
geometryBoundsInSpace: aSpartaRectangle
	
	self geometryBounds: aSpartaRectangle.
	self localBoundsToGlobal: aSpartaRectangle.
	^ aSpartaRectangle