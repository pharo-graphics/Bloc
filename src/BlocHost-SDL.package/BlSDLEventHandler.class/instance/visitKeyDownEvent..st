event handling
visitKeyDownEvent: event
	| keyEvent keysym |
	event logCr.
	keysym := event keysym.
	keyEvent := BlKeyDownEvent new
		modifiers: (self convertKeyModifiersFromModState: keysym mod);
		button: (self convertButtonFromMouseState: SDL2 mouseState);
		position: self mousePosition;
		screenPosition: self globalMousePosition;
		repeat: event repeat;
		keyValue: keysym sym;
		charCode: (self mapSpecialCharacter: keysym sym);
		scanCode: keysym scancode;
		timestamp: Time millisecondClockValue.
	^ keyEvent