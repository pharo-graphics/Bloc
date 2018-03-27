api - layout
margin: aBlInsets	
	self
		assert: [ aBlInsets isNotNil ]
		description: [ 'Margin must not be nil' ].

	self constraintsDo: [ :c | c margin: aBlInsets ]