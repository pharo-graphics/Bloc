api - time
delayedStartTime
	"Return a date and time at which animation is supposed to actually start taking delay into account"
	<return: #DateAndTime>

	self
		assert: [ self isStarted ]
		description: [ 'Animation is not yet started, I don''t know the delayed start time' ].

	^ self startTime + self delay