api - enqueue
enqueue: aBlTask	
	self
		assert: [ aBlTask isNotNil ]
		description: [ 'Task must not be nil' ].

	lock critical: [
		self
			assert: [ (tasks includes: aBlTask) not ]
			description: [ 'Task must not exist' ].
		
		tasks := tasks copyWith: aBlTask ]