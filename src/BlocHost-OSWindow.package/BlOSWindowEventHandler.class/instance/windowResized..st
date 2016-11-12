visiting window
windowResized: aPoint
	^ BlSpaceResizeEvent new
		extent: aPoint;
		timestamp: Time millisecondClockValue;
		yourself