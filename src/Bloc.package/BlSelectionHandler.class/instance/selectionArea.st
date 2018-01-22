geometry
selectionArea
	"Return bounds representing a selection area in global coordinates"
	<return: #BlBounds>
	self
		assert: [ origin isNotNil and: [ corner isNotNil ] ]
		description: [ 'Selection origin and corner must be known' ].

	^ area