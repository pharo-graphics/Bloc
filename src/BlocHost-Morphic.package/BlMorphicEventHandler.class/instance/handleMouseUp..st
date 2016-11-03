event handling
handleMouseUp: anEvent
	self convertMousePosition: anEvent andDo: [ :aMorphicEvent | 
		| akEvt |
		akEvt := BlMouseUpEvent new
			timestamp: aMorphicEvent timeStamp;
			position: aMorphicEvent position;
			yourself.
		self enqueue: akEvt]