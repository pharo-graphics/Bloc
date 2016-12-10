hooks - children
onChildDetached: anElement
	"I sent when an item element is detached from this InfiniteElement.
	My subclasses may want to perform extra bookkeeping or modifications
	of child elements as they become detached. This will be sent as an
	InfiniteLayout fully detaches the child element from the parent"