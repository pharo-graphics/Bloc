events
handleEvent: anEvent
	"convert the event to bloc one and process it"
	| aBlEvent |
	
	aBlEvent := anEvent accept: self.
	
	"for the moment, there are some unconverted events, it will be fixed soon"
	(aBlEvent isKindOf: BlEvent)
		ifTrue: [ self enqueue: aBlEvent ].
	
	
	