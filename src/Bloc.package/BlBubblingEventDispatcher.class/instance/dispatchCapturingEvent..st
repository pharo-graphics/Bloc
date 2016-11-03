dispatching
dispatchCapturingEvent: anEvent
	self filters dispatchEvent: anEvent.
	^ anEvent