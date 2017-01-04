geometry bounds
geomBoundsInSpace: aSpartaRectangle
	
	self geomBounds: aSpartaRectangle.
	self localBoundsToGlobal: aSpartaRectangle.
	^ aSpartaRectangle