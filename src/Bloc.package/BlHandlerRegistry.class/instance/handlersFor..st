accessing
handlersFor: anEvent
	self handlers select: [ :h | h wantsEvent: anEvent ]