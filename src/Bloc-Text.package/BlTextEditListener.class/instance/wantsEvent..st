events
wantsEvent: anEvent
	^ (super wantsEvent: anEvent) or: [ self wantedEvents includes: anEvent class ]