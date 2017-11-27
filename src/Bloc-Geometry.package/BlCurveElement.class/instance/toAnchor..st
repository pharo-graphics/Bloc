anchor - accessing
toAnchor: aBlGeometryAnchor
	
	self unregisterAnchor: toAnchor.
	toAnchor := aBlGeometryAnchor.
	self registerAnchor: aBlGeometryAnchor