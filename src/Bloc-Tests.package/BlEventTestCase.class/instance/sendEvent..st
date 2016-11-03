as yet unclassified
sendEvent: anEvent
	anEvent timestamp: Time millisecondClockValue.
	space eventListener handleEvent: anEvent