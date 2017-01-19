visiting
visitMotionEvent: aGdkEvent
	|evt|
	evt := BlMouseMoveEvent new
		position: aGdkEvent x @ aGdkEvent y;
		screenPosition: (self globalMousePositionForEvent: aGdkEvent);
		modifiers: (self convertKeyModifiersFromModState: aGdkEvent state);
		timestamp: Time millisecondClockValue.
		
	self hostSpace enqueueEvent: evt