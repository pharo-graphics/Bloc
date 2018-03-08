event handling
shouldHandleMouseEvents
	"Return true if I am allowed to handle mouse events.
	Preventing me from handling mouse event does not stop my children from doing so"
	<return: #Boolean>

	^ shouldHandleMouseEvents