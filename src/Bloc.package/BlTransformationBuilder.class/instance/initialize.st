initialization
initialize
	super initialize.
	
	transformation := BlAffineCompositeTransformation new.
	origin := BlAffineTransformationCenterOrigin new