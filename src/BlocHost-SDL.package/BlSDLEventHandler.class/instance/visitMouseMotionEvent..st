event handling
visitMouseMotionEvent: event
	^ BlMouseMoveEvent new
		position: event x @ event y;
		screenPosition: (self globalMousePositionForEvent: event);
		delta: event xrel @ event yrel;
		modifiers: (self convertKeyModifiersFromModState: SDL2 modState);
		"button: (self convertButtonFromMouseEvent: event);"
		timestamp: Time millisecondClockValue