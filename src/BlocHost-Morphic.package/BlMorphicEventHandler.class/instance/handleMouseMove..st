event handling
handleMouseMove: anEvent
	self convertMousePosition: anEvent andDo: [ :aMorphicEvent | 
		| akEvt |
		akEvt := BlMouseMoveEvent new
			timestamp: aMorphicEvent timeStamp;
			position: aMorphicEvent position;
			yourself.
		self enqueue: akEvt]