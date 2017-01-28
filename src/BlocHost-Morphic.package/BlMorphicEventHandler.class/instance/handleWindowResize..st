event handling
handleWindowResize: aMorphicEvent
	| aBlEvent |
	aBlEvent := BlSpaceResizeEvent new
		extent: aMorphicEvent width @ aMorphicEvent height;
		timestamp: Time millisecondClockValue;
		yourself.
	self enqueue: aBlEvent