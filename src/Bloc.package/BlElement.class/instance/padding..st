api - layout
padding: aBlInsets
	self
		assert: [ aBlInsets isNotNil ]
		description: [ 'Padding must not be nil' ].

	self constraintsDo: [ :c | c padding: aBlInsets ]