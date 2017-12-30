api - look
background: aBlBackground
	"Change my background to a given one.
	Color and Form can be used as background - they will be converted to appropriate background object.
	It is also possible to create a more complicated composite background with the help of ==BlBackgroundBuilder==.

	aBlBackground must not be nil"
	<event: #BlElementBackgroundChangedEvent>

	self
		assert: [ aBlBackground isNotNil ]
		description: [ 'Background must not be nil' ].

	background := aBlBackground asBlBackground.
	self dispatchEvent: (BlElementBackgroundChangedEvent target: self).
	self invalidate