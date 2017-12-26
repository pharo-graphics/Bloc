changes
onBorderChanged
	<event: #BlElementBorderChangedEvent>

	self owner dispatchEvent: (BlElementBorderChangedEvent target: self owner).
	self owner invalidate