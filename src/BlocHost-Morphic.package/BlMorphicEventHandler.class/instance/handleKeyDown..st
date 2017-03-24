event handling
handleKeyDown: aMorphicEvent
	| aBlEvent |
	
	aBlEvent := BlKeyDownEvent new
		keyValue: aMorphicEvent keyValue;
		charCode: aMorphicEvent keyCharacter;
		scanCode: aMorphicEvent scanCode;
		modifiers: (self convertKeyModifiersFromEvent: aMorphicEvent);
		timestamp: Time millisecondClockValue;
		position: aMorphicEvent position;
		screenPosition: (self globalMousePositionForEvent: aMorphicEvent).

	self enqueue: aBlEvent