event handling
handleKeyUp: aMorphicEvent
	| aBlEvent |
		
	aBlEvent := BlKeyUpEvent new
		key: aMorphicEvent key;
		scanCode: aMorphicEvent scanCode;
		
		modifiers: (self convertKeyModifiersFromEvent: aMorphicEvent);
		timestamp: Time millisecondClockValue;
		position: aMorphicEvent position;
		screenPosition: (self globalMousePositionForEvent: aMorphicEvent).

	self enqueue: aBlEvent