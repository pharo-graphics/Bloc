visiting keyboard
visitTextInputEvent: anEvent
	| textEvent |
	anEvent text ifNil: [ ^ nil ].
	^ BlTextInputEvent new
		modifiers: (self convertKeyModifiers: anEvent modifiers);
		text: anEvent text;
		timestamp: DateAndTime now.