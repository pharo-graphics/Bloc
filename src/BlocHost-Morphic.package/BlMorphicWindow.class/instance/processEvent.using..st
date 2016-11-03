morphic events handling
processEvent: anEvent using: defaultDispatcher
	(self isInDrawingArea: anEvent)
		ifFalse: [ ^ super processEvent: anEvent using: defaultDispatcher ].
	
	anEvent sentTo: self internalEventHandler.
	anEvent wasHandled:true.