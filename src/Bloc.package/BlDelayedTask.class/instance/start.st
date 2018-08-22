api - running
start
	self
		assert: [ element isNotNil ]
		description: [ 'Task must be attached to the element' ].

	isRunning := true.
	startTime := self time now.
	element ifNotNil: [ self dequeue ].
	self enqueue