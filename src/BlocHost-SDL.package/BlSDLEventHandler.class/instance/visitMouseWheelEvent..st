event handling
visitMouseWheelEvent: event
	| vertical |
	vertical := event y.
	^ BlScrollEvent new
		modifiers: (self convertKeyModifiersFromModState: SDL2 modState);
		button: (self convertButtonFromMouseState: SDL2 mouseState);
		position: self mousePosition;
		screenPosition: self globalMousePosition;
		direction: (vertical > 0 ifTrue: [ Character arrowUp ] ifFalse: [ Character arrowDown ]);
		timestamp: Time millisecondClockValue