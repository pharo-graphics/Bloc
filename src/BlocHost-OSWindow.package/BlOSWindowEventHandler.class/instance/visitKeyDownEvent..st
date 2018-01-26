visiting keyboard
visitKeyDownEvent: anEvent
	| keyEvent mods |
	mods := anEvent modifiers.

	keyEvent := BlKeyDownEvent new
		modifiers: (self convertKeyModifiers: mods);
		position: anEvent position;
		screenPosition: window position + anEvent position;
		repeat: anEvent repeat;
		keyValue: anEvent symbol;
		charCode: (self mapSymbolToKeyValue: anEvent symbol);
		scanCode: anEvent scanCode;
		timestamp: DateAndTime now.
	
	
	^ keyEvent