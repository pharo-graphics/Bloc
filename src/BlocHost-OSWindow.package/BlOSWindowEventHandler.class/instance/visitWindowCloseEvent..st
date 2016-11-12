visiting window
visitWindowCloseEvent: anEvent
	anEvent suppressDefaultAction.
	^ BlSpaceCloseEvent new
		timestamp: Time millisecondClockValue;
		yourself