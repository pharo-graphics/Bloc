event handling
handleWindowClose: aMorphicEvent
	| akEvt |
	akEvt := BlWindowCloseEvent new
		timestamp: aMorphicEvent timeStamp;
		yourself.
	self enqueue: akEvt