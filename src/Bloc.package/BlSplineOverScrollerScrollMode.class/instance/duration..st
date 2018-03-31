accessing
duration: aDuration

	self
		assert: [ aDuration isNumber not ]
		description: [ 'Duration must not be a typeless number' ].

	duration := aDuration