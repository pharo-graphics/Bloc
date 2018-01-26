visiting window
visitWindowCloseEvent: anEvent
	anEvent suppressDefaultAction.
	^ BlSpaceCloseRequest new
		timestamp: DateAndTime now;
		yourself