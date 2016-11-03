visiting window
visitWindowFocusInEvent: anEvent
	^ BlWindowFocusInEvent new
		timestamp: Time millisecondClockValue;
		yourself