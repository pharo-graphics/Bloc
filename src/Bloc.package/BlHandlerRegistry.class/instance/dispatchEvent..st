api - event managing
dispatchEvent: anEvent
	"Dispatch a given event to all registered handlers that are interested in it"

	self subclassResponsibility