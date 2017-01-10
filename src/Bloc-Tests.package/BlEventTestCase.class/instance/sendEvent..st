event firing
sendEvent: anEvent
	anEvent timestamp: Time millisecondClockValue.
	space eventListener handleEvent: anEvent