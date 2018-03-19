event handling
shouldChildrenHandleMouseEvents
	"Return true if my children are allowed to handle mouse events.
	Preventing my children from handling mouse event does not stop me from handling them"
	<return: #Boolean>

	^ shouldChildrenHandleMouseEvents