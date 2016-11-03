event processing entrypoint
processMouseDown: aMouseDownEvent
	"picking and mouse move"
	self preProcess: aMouseDownEvent.
	"start still down"
	isMouseStillDown := isMouseStillDown bitOr: aMouseDownEvent button.
	"store last mouse down event"
	lastMouseDownEvent := aMouseDownEvent.
	"does nothing for the moment"
	self postProcess: aMouseDownEvent