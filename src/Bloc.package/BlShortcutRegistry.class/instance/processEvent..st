events-processing
processEvent: aKeyEvent
	| sc |
	"no process for repeated key events"
	aKeyEvent repeat = 0 ifFalse: [ ^ self ].
	
	eventBuffer addEvent: aKeyEvent.
	sc := self matchingShortcut: eventBuffer.
	sc	ifNotNil: [ 
			eventBuffer clear.
			pendingShortcuts removeAll.
			sc action value ]