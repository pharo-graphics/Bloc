anchor - accessing
toAnchor: aBlGeometryAnchor
	super toAnchor: aBlGeometryAnchor.

	curvatureAnchor referenceAnchors: { self fromAnchor . self toAnchor }