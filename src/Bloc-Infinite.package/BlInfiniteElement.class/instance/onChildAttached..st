hooks - children
onChildAttached: anElement
	"Sent when an item element is attached to this InfiniteElement.
	My subclasses may want to perform extra bookkeeping or modifications of child elements
	as they become attached. This will be called before an InfiniteLayout measures or lays out
	the element and is a good time to perform these changes"