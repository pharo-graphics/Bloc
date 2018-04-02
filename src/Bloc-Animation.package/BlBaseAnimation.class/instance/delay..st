api - configuration
delay: aDuration
	self
		assert: [ aDuration >= 0 seconds ]
		description: [ 'Delay must not be negative' ].
	
	delay := aDuration asDuration