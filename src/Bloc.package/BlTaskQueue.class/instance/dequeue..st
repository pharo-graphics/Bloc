api - enqueue
dequeue: aBlTask	
	self
		assert: [ aBlTask isNotNil ]
		description: [ 'Task must not be nil' ].

	lock critical: [ tasks := tasks copyWithout: aBlTask ]