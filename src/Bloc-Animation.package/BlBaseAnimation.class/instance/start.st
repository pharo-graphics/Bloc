api - running
start
	self
		assert: [ self parent isNil ]
		description: [ 'A sub-animation has to be started from its parent' ].
	
	self
		assert: [ self isRunning not ]
		description: [ 'Animation can not be start multiple times without stop' ].

	self initStart