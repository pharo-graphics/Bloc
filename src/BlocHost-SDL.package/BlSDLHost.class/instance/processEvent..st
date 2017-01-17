private - event
processEvent: sdlEvent
	| aMappedEvent |
	
	aMappedEvent := sdlEvent mapped.
	"events without windowID should be handled by all windows"
	aMappedEvent windowID
		ifNil: [ self processCommonEvent: aMappedEvent ]
		ifNotNil: [ self processWindowEvent: aMappedEvent ].

	BlUniverse default requestNextPulse