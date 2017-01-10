accessing
matchExtent: anExtent
	extent := anExtent.
	self vertices: (self verticesForBounds: self geometryBounds)