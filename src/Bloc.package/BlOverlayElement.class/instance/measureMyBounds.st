layout
measureMyBounds
	"I compute by position and size in relation to the reference element"
	self
		assert: [ self isAttached ]
		description: [ 'I must be attached to the reference element to measure myself' ].
		
	self relocate: (overlayListener positionFor: referenceElement).
	self size: (overlayListener extentFor: referenceElement).