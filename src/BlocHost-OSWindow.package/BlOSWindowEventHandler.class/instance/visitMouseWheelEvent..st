visiting - mouse
visitMouseWheelEvent: anEvent
	| vertical horizontal |
	
	horizontal := anEvent scrollHorizontal.
	vertical := anEvent scrollVertical.
	
	(horizontal isZero and: [ vertical isZero ])
		ifTrue: [ ^ self ].
	
	^ BlMouseWheelEvent new
		vector: (BlVector x: horizontal negated y: vertical);
		position: anEvent position;
		screenPosition: window position + anEvent position;
		direction: (vertical > 0 ifTrue: [Character arrowUp] ifFalse: [Character arrowDown]);
		modifiers: (self convertKeyModifiers: anEvent modifiers);
		timestamp: DateAndTime now