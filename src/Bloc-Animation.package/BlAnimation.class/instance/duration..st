api - configuration
duration: aDuration
	self
		assert: [ aDuration > 0 seconds ]
		description: [ 'Duration must be positive' ].

	duration := aDuration asDuration