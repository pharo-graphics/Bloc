event handling
handleKeyDown: aMorphicEvent
	| aBlEvent |
	
	(self isScrollEvent: aMorphicEvent)
		ifTrue: [ ^ self ].
	
	aBlEvent := BlKeyDownEvent new
		key: aMorphicEvent key;
		scanCode: aMorphicEvent scanCode;
		
		modifiers: (self convertKeyModifiersFromEvent: aMorphicEvent);
		timestamp: DateAndTime now;
		position: aMorphicEvent position;
		screenPosition: (self globalMousePositionForEvent: aMorphicEvent).

	self enqueue: aBlEvent