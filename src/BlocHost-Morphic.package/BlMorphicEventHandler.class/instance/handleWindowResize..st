event handling
handleWindowResize: aMorphicEvent
	| akEvt |
	akEvt := BlWindowResizeEvent new
		extent: aMorphicEvent width @ aMorphicEvent height;
		timestamp: aMorphicEvent timeStamp;
		yourself.
	self enqueue: akEvt