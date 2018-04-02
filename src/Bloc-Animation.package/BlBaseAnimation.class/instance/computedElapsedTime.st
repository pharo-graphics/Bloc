api - time
computedElapsedTime
	"Return elapsed time (a duration) since actual animation start of the current loop including delay"
	<return: #Duration>
	self
		assert: [ self isStarted ]
		description: [ 'Animation is not yet started, I don''t know the elapsed time' ].

	^ (self time now - self delayedStartTime) min: self duration