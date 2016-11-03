visiting window
windowResized: aPoint
	^ BlWindowResizeEvent new
		extent: aPoint;
		timestamp: Time millisecondClockValue;
		yourself