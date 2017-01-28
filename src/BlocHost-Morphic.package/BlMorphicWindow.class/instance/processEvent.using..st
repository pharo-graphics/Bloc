events-processing
processEvent: anEvent using: defaultDispatcher

	(self isInSpaceArea: anEvent)
		ifFalse: [ ^ super processEvent: anEvent using: defaultDispatcher ].

	anEvent sentTo: eventHandler.
	anEvent wasHandled: true