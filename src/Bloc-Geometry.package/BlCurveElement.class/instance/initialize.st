initialization
initialize
	super initialize.
	
	fromAnchor := self defaultFromAnchor.
	toAnchor := self defaultToAnchor.
	viaAnchors := OrderedCollection new