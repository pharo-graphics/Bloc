api - bounds
relocate: aPoint
	"Request my position change in parent coordinates that will happen on the next frame or next layout pass triggered by #forceLayout.

	Note: I do not invalidate drawing bounds nor change actual position.
	I only register an update request and ask my parent (if there is one) to recompute
	layout. Do nothing if previous #relocate request was performed with the same coordinates.
	Note: We can not guarantee that new element's position will be equal to reqeusted one,
	since it depends on the applied layout.
	aPoint must not be nil"
	<event: #BlElementPositionChangedEvent>
	<event: #BlElementPositionInSpaceChangedEvent>

	self
		assert: [ aPoint isNotNil ]
		description: [ 'aPoint must not be nil' ].

	self measuredBounds position = aPoint
		ifTrue: [ ^ self ].

	self measuredBounds position: aPoint.
	self requestParentLayout