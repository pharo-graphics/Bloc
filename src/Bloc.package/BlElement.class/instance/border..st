api - look
border: aBlBorder
	"Change my border and invalidate me"
	<event: #BlElementBorderChangedEvent>

	self
		assert: [ aBlBorder isNotNil ]
		description: [ 'Background must not be nil' ].

	border := aBlBorder.
	self dispatchEvent: (BlElementBorderChangedEvent target: self).
	self invalidate