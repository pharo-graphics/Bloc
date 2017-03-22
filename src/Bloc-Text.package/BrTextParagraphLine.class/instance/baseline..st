accessing
baseline: aPoint
	super baseline: aPoint.
	
	spans inject: aPoint into: [ :point :span |
		span baseline: point.
		(point x + span width) @ point y ]