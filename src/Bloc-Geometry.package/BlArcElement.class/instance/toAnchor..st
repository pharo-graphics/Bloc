anchor - accessing
toAnchor: aBlGeometryAnchor

	self unregisterAnchor: toAnchor.
	toAnchor := aBlGeometryAnchor.
	self registerAnchor: aBlGeometryAnchor.

	curvatureAnchor referenceAnchors: { self fromAnchor . self toAnchor }