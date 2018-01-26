visiting keyboard
visitKeyUpEvent: anEvent
	| keyEvent |
	keyEvent := BlKeyUpEvent new
		modifiers: (self convertKeyModifiers: anEvent modifiers);
		position: anEvent position;
		screenPosition: window position + anEvent position;
		repeat: anEvent repeat;
		key: (Key character: anEvent character);
		scanCode: anEvent scanCode;
		charCode: (self mapSymbolToKeyValue: anEvent symbol);
		timestamp: DateAndTime now.

	^ keyEvent