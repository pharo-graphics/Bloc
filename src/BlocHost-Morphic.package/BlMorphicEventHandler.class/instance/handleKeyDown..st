event handling
handleKeyDown: aMorphicEvent

	"| aBlEvent |
	aBlEvent := BlMouseDownEvent new
			position: aMorphicEvent position;
			screenPosition: (self globalMousePositionForEvent: aMorphicEvent);
			modifiers: (self convertKeyModifiersFromEvent: aMorphicEvent);
			button: (self convertButtonFromMouseButtonEvent: aMorphicEvent);
			timestamp: Time millisecondClockValue
			yourself.
		self enqueue: aBlEvent"