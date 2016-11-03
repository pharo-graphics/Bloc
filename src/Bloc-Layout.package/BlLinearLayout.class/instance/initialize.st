initialization
initialize
	super initialize.
	
	weightSum := self defaultWeightSum.
	verticalAlignment := self defaultVerticalAlignment.
	horizontalAlignment := self defaultHorizontalAlignment.
	cache := self defaultCache.
	
	self orientation: self defaultOrientation.