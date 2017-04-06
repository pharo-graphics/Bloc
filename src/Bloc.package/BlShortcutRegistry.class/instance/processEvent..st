events-processing
processEvent: aKeyEvent
	| sc |

	"no process for repeated key events"
	aKeyEvent repeat isZero ifFalse: [ ^ self ].
	eventBuffer removeConsumed.
	eventBuffer addEvent: aKeyEvent.
	sc := self matchingShortcut: eventBuffer.
	sc ifNil:[^ self "do nothing"].
	
	eventBuffer clear.
	pendingShortcuts removeAll.
	sc action value.
	aKeyEvent consumed: true 