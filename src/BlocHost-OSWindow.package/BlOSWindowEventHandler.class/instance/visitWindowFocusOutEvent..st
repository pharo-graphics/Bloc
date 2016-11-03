visiting window
visitWindowFocusOutEvent: anEvent
	^ BlWindowFocusOutEvent new
		timestamp: Time millisecondClockValue;
		yourself