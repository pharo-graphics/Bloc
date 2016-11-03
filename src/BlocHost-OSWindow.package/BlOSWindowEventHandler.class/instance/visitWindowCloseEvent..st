visiting window
visitWindowCloseEvent: anEvent
	anEvent suppressDefaultAction.
	^ BlWindowCloseEvent new
		timestamp: Time millisecondClockValue;
		yourself