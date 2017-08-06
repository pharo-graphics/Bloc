asserting
assertSpan

	self
		assert: [ span isNotNil and: [ spanStart isNotNil and: [ spanEnd isNotNil ] ] ]
		description: [ 'Span is not initialized' ].