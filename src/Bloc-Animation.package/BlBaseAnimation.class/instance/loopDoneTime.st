api - time
loopDoneTime
	<return: #DateAndTime>

	self
		assert: [ self isStarted ]
		description: [ 'Animation is not yet started, I don''t know the loop end time' ].
	
	self
		assert: [ self atLeastOneLoopDone ]
		description: [ 'Loop is not ended yet' ].

	^ loopDoneTime