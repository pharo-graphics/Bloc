event managing
dispatchEvent: anEvent
	"Dispatch a given event though the whole dispatcher chain"
	self hasNextEventDispatcher
		ifFalse: [ ^ anEvent ].

	^ self nextEventDispatcher dispatchEvent: anEvent chain: self