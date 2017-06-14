event processing
enqueueEvent: aBlEvent
	"Enqueue a given Bloc Event in the event queue.
	I can be used for testing and benchmark purposes"

	eventQueue nextPut: aBlEvent.
	BlUniverse default requestNextPulse