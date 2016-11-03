event managing
dispatchEvent: anEvent
	self hasNextEventDispatcher ifFalse: [ ^ anEvent ].
	^ self nextEventDispatcher dispatchEvent: anEvent chain: self