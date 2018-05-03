events
handleEvent: anEvent
	"convert the event to bloc one and process it"
	| theEvents |
	
	theEvents := (anEvent accept: self) asOrderedCollection.
	
	"for the moment, there are some unconverted events, it will be fixed soon"
	theEvents do: [ :aBlEvent |
		(aBlEvent isKindOf: BlEvent)
			ifTrue: [ self enqueue: aBlEvent ] ].
	
	
	