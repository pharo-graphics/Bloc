api - event managing
wantsEvent: anEvent
	"Return true if my current conditions allow me to dispatch a given event, false otherwise.
	Default implementation always returns true. Override me to customize the behaviour"
	<return: #Boolean>

	^ true