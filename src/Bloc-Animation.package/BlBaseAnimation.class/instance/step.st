api - running
step
	
	self shouldStartNextLoop
		ifTrue: [ self startNextLoop ].

	"Time did not come for me to run because of delay"	
	self time now < self delayedStartTime
		ifTrue: [ ^ self ].

	previousStepTime := self time now.
	elapsedTime := self computedElapsedTime.

	self
		assert: [ self duration isZero not ]
		description: [ 'Duration must not be zero' ].
	progress := (elapsedTime / self duration) asFloat.
	self
		assert: [ progress between: 0 and: 1 ]
		description: [ 'Progress must be within interval [0..1]' ].

	progress <= 1.0
		"Animation is not over yet, execute an actual animation step"
		ifTrue: [ self doStep ].

	progress >= 1
		ifTrue: [ self onLoopDone ].
		
	(self shouldStartNextLoop
		and: [ self time now > self nextLoopStartTime ])
			ifTrue: [ self step ]