event firing
fireEvent: anEvent
	firedEvents add: anEvent.

	^ super fireEvent: anEvent