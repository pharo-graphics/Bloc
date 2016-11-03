event processing entrypoint
processMouseScroll: aMouseScrollEvent
	"picking and mouse move"
	self preProcess: aMouseScrollEvent.
	"does nothing for the moment"
	self postProcess: aMouseScrollEvent