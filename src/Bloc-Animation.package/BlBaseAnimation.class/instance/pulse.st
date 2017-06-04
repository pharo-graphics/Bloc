pulse
pulse

	"Time did not come for me to run because of delta, just request next step and quit"
	Time millisecondClockValue < (startTime + delay)
		ifTrue: [ ^ self requestNextStep ].

	elapsedTime := self computeElapsedTime.
	progress := (elapsedTime / duration) asFloat.
	
	progress >= 1
		ifFalse: [
			"Animation is not over yet, perform a step and request a next one"
			self doStep.
			self requestNextStep ]
		ifTrue: [
			"We have done an animation loop, notify listeners"
			self notifyOnFinishedHandlers.
			loopCount := loopCount + 1.
			
			(self isInfinite or: [ loopCount < loop ])
				"If I am an infinite animation and loop limit is not hit
				we prepare ourselves for a next loop and request a step"
				ifTrue: [
					self initStart.
					self requestNextStep ]
				"otherwise stop animation and remove it from manager"
				ifFalse: [ self stop ] ]
	
	