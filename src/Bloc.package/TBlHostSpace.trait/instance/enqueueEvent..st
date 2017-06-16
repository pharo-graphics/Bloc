host space - events
enqueueEvent: aBlEvent
	"Enqueue a given Bloc Event in the event queue.
	I am useful for testing and benchmark purposes"

	self eventFetcher enqueueEvent: aBlEvent.
	self space requestNextPulse