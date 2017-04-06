event handling
handleKeyUp: aMorphicEvent
	| aBlEvent |
	
	aBlEvent := BlKeyUpEvent new
		keyValue: aMorphicEvent keyValue;
		charCode: aMorphicEvent keyCharacter;
		button: aMorphicEvent keyCharacter;
		scanCode: aMorphicEvent scanCode;
		modifiers: (self convertKeyModifiersFromEvent: aMorphicEvent);
		timestamp: Time millisecondClockValue;
		position: aMorphicEvent position;
		screenPosition: (self globalMousePositionForEvent: aMorphicEvent).

	self enqueue: aBlEvent