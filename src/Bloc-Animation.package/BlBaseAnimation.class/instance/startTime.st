api - time
startTime
	"Return a date and time at which animation was started"
	<return: #DateAndTime>

	self
		assert: [ self isStarted ]
		description: [ 'Animation is not yet started, I don''t know the start time' ].

	^ startTime