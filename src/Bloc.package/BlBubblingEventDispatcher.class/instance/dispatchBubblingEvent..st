dispatching
dispatchBubblingEvent: anEvent
	
	"handlers initialized lazily, do nothing if there are none of them"
	handlers ifNotNil: [ :theHandlers |
		theHandlers dispatchEvent: anEvent ].

	^ anEvent