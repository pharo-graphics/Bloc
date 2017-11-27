initialization
initialize
	super initialize.
	
	fromAnchor := self defaultFromAnchor.
	toAnchor := self defaultToAnchor.
	self wantsMouse: false