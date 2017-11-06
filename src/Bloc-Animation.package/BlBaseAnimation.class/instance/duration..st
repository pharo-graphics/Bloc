accessing api
duration: aDuration
	self
		assert: [ aDuration > 0 seconds ]
		description: [ 'Duration has to be positive' ].

	duration := aDuration asDuration