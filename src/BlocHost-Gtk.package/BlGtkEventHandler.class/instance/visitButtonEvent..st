visiting
visitButtonEvent: aGdkEvent
	| evt |
	
	aGdkEvent type = GdkEventType GDK_BUTTON_PRESS
		ifTrue: [ evt := BlMouseDownEvent new ].
	aGdkEvent type = GdkEventType GDK_BUTTON_RELEASE
		ifTrue: [ evt := BlMouseUpEvent new ].
		
	evt
		position: aGdkEvent x @ aGdkEvent y;
		screenPosition: (self globalMousePositionForEvent: aGdkEvent);
		modifiers: (self convertKeyModifiersFromModState: aGdkEvent state);
		button: (self convertButtonFromMouseEvent: aGdkEvent);
		timestamp: Time millisecondClockValue.
		
	self hostSpace enqueueEvent: evt