event handling
handleMouseDown: anEvent

	self convertMousePosition: anEvent andDo: [ :aMorphicEvent | 
			| akEvt |
			akEvt := BlMouseDownEvent new
				timestamp: aMorphicEvent timeStamp;
				position: aMorphicEvent position;
				yourself.
			self enqueue: akEvt ]