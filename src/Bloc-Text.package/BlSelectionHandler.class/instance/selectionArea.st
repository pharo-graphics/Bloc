geometry
selectionArea
	self
		assert: [ origin isNotNil and: [ corner isNotNil ] ]
		description: [ 'Selection origin and corner must be known' ].

	^ (origin min: corner) corner: (corner max: origin)