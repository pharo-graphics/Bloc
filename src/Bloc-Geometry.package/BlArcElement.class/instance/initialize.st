initialization
initialize
	super initialize.
	
	fromAnchor := self defaultFromAnchor.
	toAnchor := self defaultToAnchor.
	curvatureAnchor := self defaultViaAnchor referenceAnchors: { fromAnchor . toAnchor }.

	self wantsMouse: false