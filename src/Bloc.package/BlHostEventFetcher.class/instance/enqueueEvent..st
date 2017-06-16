event processing
enqueueEvent: aBlEvent
	"Enqueue a given Bloc Event in the event queue.
	Do not use me directly, instead rely on #enqueueEvent: from HostSpace"

	eventQueue nextPut: aBlEvent