visiting window
visitWindowMouseEnterEvent: anEvent
	^ BlWindowMouseEnterEvent new
		timestamp: Time millisecondClockValue;
		yourself