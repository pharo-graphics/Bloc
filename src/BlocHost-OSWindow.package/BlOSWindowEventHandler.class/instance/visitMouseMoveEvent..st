visiting mouse
visitMouseMoveEvent: anEvent
	^ BlMouseMoveEvent new
		position: anEvent position;
		screenPosition: window position + anEvent position;
		delta: anEvent delta;
		modifiers: (self convertKeyModifiers: anEvent modifiers);
		timestamp: DateAndTime now;
		yourself