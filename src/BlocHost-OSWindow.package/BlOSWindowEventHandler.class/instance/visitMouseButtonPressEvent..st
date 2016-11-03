visiting mouse
visitMouseButtonPressEvent: anEvent

	^ BlMouseDownEvent new
		position: anEvent position;
		delta: anEvent delta;
		button: (self convertButton: anEvent button);
		modifiers: (self convertKeyModifiers: anEvent modifiers);
		timestamp: Time millisecondClockValue