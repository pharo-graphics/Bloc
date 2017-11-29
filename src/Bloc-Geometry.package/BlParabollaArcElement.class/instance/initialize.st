initialization
initialize
	super initialize.
	
	curvatureAnchor := self defaultViaAnchor referenceAnchors: { self fromAnchor . self toAnchor }