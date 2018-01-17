event handling
handleWindowResize: aMorphicEvent
	| aBlEvent |
	aBlEvent := BlSpaceResizeEvent new
		extent: aMorphicEvent width @ aMorphicEvent height;
		timestamp: DateAndTime now;
		yourself.
	self enqueue: aBlEvent