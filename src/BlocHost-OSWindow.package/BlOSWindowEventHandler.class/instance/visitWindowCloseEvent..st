visiting window
visitWindowCloseEvent: anEvent
	anEvent suppressDefaultAction.
	^ BlSpaceCloseRequest new
		timestamp: Time millisecondClockValue;
		yourself