private - testing
canHaveNextLoop
	<return: #Boolean>

	self
		assert: [ self isRunning ]
		description: [ 'I must be running' ].

	^ self isInfinite or: [ loopCount < loop ]