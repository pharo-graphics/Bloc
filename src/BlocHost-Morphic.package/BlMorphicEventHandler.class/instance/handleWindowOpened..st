event handling
handleWindowOpened: aMorphicEvent
	| aBlEvent |
	
	aBlEvent := BlSpaceCloseRequest new
		timestamp: DateAndTime now.

	self enqueue: aBlEvent