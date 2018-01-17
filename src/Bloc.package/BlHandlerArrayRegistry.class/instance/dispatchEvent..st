api - event managing
dispatchEvent: anEvent
	"Dispatch a given event to all registered handlers that are interested in it"
	| theHandlers |

	"inlined version of select:thenDo:"
	theHandlers := handlers. "we must store reference to previous handlers"
	1 to: theHandlers size do: [ :index | | each |
		((each := theHandlers at: index) wantsEvent: anEvent)
			ifTrue: [
				anEvent prepareForDelivery.
				each handleEvent: anEvent ] ]