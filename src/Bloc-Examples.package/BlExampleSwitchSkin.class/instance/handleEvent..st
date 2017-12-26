event handling
handleEvent: anEvent
	super handleEvent: anEvent.
	
	(anEvent isKindOf: BlExampleSwitchEventActivated)
		ifTrue: [ self switchActivated ].
	(anEvent isKindOf: BlExampleSwitchEventDeactivated)
		ifTrue: [ self switchDeactivated ].