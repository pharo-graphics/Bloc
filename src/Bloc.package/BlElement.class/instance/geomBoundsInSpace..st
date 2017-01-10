geometry bounds
geomBoundsInSpace: aSpartaRectangle
	
	self geometryBounds: aSpartaRectangle.
	self localBoundsToGlobal: aSpartaRectangle.
	^ aSpartaRectangle