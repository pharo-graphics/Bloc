event handling
visitTextInputEvent: event
	^ BlTextInputEvent new
		modifiers: (self convertKeyModifiersFromModState: SDL2 modState);
		button: (self convertButtonFromMouseState: SDL2 mouseState);
		position: self mousePosition;
		screenPosition: self globalMousePosition;
		text: (ZnUTF8Encoder new decodeBytes: event text);
		timestamp: Time millisecondClockValue