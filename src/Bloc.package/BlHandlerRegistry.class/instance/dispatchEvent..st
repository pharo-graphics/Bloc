event managing
dispatchEvent: anEvent
	"Dispatch a given event to all registered handlers that are interested in it"

	"inlined version of select:thenDo:"
	1 to: handlers size do: [ :index | | each |
		((each := handlers at: index) wantsEvent: anEvent)
			ifTrue: [ each handleEvent: anEvent ] ]