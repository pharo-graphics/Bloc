api - enqueue
enqueueAll: aCollectionOfBlTask	
	self
		assert: [ aCollectionOfBlTask isNotNil ]
		description: [ 'Tasks must not be nil' ].

	lock critical: [
		self
			assert: [ (tasks includesAny: aCollectionOfBlTask) not ]
			description: [ 'Tasks must not exist' ].
		
		tasks := tasks copyWithAll: aCollectionOfBlTask ]