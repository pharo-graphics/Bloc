api - time
nextLoopStartTime
	"Return a date and time at which the next animation repeat is supposed to start without taking delay of the next step into account"
	<return: #DateAndTime>

	self
		assert: [ self isStarted ]
		description: [ 'Animation is not yet started, I don''t know the delayed start time' ].

	^ self delayedStartTime + self duration