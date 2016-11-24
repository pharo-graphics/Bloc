event management
fireEvent: anEvent
	"I fire and dispatch provided event with myself as target.
	anEvent must not be nil"

	BlEvent fireEvent: anEvent target: self