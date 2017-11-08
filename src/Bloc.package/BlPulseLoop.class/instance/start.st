lifecycle
start

	self isRunning
		ifTrue: [ ^ self ].

	self
		assert: [ loopProcess isNil ]
		description: [ 'Loop process must not exist' ].

	loopProcess := self createLoopProcess.
	loopProcess resume