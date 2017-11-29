anchor - accessing
fromAnchor: aBlGeometryAnchor
	super fromAnchor: aBlGeometryAnchor.
	
	curvatureAnchor referenceAnchors: { self fromAnchor . self toAnchor }