anchor - accessing
fromAnchor: aBlGeometryAnchor

	self unregisterAnchor: fromAnchor.
	fromAnchor := aBlGeometryAnchor.
	self registerAnchor: aBlGeometryAnchor.
	
	curvatureAnchor referenceAnchors: { self fromAnchor . self toAnchor }