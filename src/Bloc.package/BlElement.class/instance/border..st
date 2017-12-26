api - look
border: aBorder
	"Change my border and invalidate me"

	border := aBorder.
	self dispatchEvent: (BlElementBorderChangedEvent target: self).
	self invalidate.