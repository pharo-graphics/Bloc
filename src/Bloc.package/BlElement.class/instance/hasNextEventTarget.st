event management accessing
hasNextEventTarget
	"Return true if this event target has a logical successor within a dispatch chain.
	For example, in case of visual components next event target is a parent, meaning
	that first event is handled by child and the dispatched to the parent if that event
	was not consumed"
	<return: #Boolean>

	^ self hasParent