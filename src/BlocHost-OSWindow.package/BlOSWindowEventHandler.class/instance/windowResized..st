visiting window
windowResized: aPoint
	^ BlSpaceResizedEvent new
		extent: aPoint;
		timestamp: DateAndTime now;
		yourself