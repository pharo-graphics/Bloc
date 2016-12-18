notifying
notifyChildAttached: anElement
	"Notify all event handlers that element is attached to InfiniteElement"

	self fireEvent: (BlInfiniteElementAttachedEvent element: anElement)