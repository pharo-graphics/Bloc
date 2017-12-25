event handling
handleWindowOpened: aMorphicEvent
	| aBlEvent |
	
	aBlEvent := BlSpaceCloseRequest new
		timestamp: Time millisecondClockValue.

	self enqueue: aBlEvent