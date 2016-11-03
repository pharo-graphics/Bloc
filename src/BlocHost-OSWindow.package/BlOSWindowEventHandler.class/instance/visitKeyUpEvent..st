visiting keyboard
visitKeyUpEvent: anEvent
	| keyEvent |
	keyEvent := BlKeyUpEvent new
		modifiers: (self convertKeyModifiers: anEvent modifiers);
		position: anEvent position;
		screenPosition: window position + anEvent position;
		keyValue: anEvent symbol;
		scanCode: anEvent scanCode;
		charCode: (self mapSymbolToKeyValue: anEvent symbol);
		timestamp: Time millisecondClockValue.

	^ keyEvent