visiting keyboard
visitKeyDownEvent: anEvent
	| keyEvent |

	keyEvent := BlKeyDownEvent new
		key: (Key value: (self mapSymbolToKeyValue: anEvent symbol));
		scanCode: anEvent scanCode;

		modifiers: (self convertKeyModifiers: anEvent modifiers);
		timestamp: DateAndTime now;
		position: anEvent position;
		screenPosition: window position + anEvent position.
		
	keyEvent logCr.
	
	^ keyEvent