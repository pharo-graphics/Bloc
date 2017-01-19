testing
wantsEvent: anEvent
	"Return true if I current conditions allow me to dispatch a given events, false otherwise.
	Default implementation always returns true. Override me to customize behaviour"
	<return: #Boolean>

	^ true