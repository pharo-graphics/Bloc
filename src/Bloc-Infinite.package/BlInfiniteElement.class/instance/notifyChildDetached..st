notifying
notifyChildDetached: anElement
	"Notify all event handlers that element is detached from InfiniteElement"

	self fireEvent: (BlInfiniteChildDetachedEvent element: anElement)