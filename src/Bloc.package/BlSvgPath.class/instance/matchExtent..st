accessing
matchExtent: anExtent
	extent := anExtent.
	self pathData: (self pathDataWithin: self geometryBounds)