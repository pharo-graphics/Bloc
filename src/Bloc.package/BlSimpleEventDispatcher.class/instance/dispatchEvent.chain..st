dispatching
dispatchEvent: anEvent chain: aTail
	self filters dispatchEvent: anEvent.
	aTail dispatchEvent: anEvent.
	self handlers dispatchEvent: anEvent