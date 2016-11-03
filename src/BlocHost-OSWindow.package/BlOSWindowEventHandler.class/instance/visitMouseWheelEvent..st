visiting mouse
visitMouseWheelEvent: anEvent
	| vertical |
	vertical := anEvent scrollVertical.
	vertical = 0 ifTrue: [ ^ nil ].
	
	^ BlScrollEvent new
		position: anEvent position;
		screenPosition: window position + anEvent position;
		direction: (vertical > 0 ifTrue: [Character arrowUp] ifFalse: [Character arrowDown]);
		modifiers: (self convertKeyModifiers: anEvent modifiers);
		timestamp: Time millisecondClockValue