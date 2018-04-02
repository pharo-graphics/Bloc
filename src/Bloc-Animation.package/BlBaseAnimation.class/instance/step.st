api - running
step
	
	"Time did not come for me to run because of delay"
	self time now < self delayedStartTime
		ifTrue: [ ^ self ].

	elapsedTime := self computedElapsedTime.
	
	self
		assert: [ self duration isZero not ]
		description: [ 'Duration must not be zero' ].
	progress := (elapsedTime / self duration) asFloat.
	
	progress <= 1.0
		"Animation is not over yet, execute an actual animation step"
		ifTrue: [ self doStep ].

	progress >= 1
		ifTrue: [ self onLoopDone ]