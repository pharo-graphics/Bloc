events
enqueue: anBlEvent
	self eventQueue nextPut: anBlEvent.
	BlUniverse default requestNextPulse.