scheduling
postOnAnimation

	self
		assert: [ scrollable isNotNil ]
		description: [ 'Can not post on animation if I am not attached to a scrollable' ].

	eatRunOnAnimationRequest
		ifTrue: [ reSchedulePostAnimationCallback := true ]
		ifFalse: [
			self scrollable dequeueTask: self.	
			self scrollable enqueueTask: self ]