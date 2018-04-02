api - running
stop

	self
		assert: [ self isRunning ]
		description: [ 'Animation is not running' ].

	isRunning := false