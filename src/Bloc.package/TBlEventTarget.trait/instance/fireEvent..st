event management
fireEvent: anEvent
	"I fire provided event building an event dispatcher chain
	(from target to the root element) and dispatch the event with it.
	anEvent must not be nil"

	BlEvent fireEvent: anEvent target: self