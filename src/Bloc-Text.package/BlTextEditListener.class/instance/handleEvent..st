event handling
handleEvent: anEvent
	(self wantedEvents includes: anEvent class)
		ifTrue: [ anEvent handleBy: self ]
		ifFalse: [ super handleEvent: anEvent ]