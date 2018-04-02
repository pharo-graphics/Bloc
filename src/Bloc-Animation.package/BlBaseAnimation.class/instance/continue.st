api - running
continue
	"try to prepare animation for the next loop and return true if animation should continue, false otherwise"
	<return: #Boolean>

	"We have done an animation loop, notify listeners"
	self notifyOnFinishedHandlers.

	loopCount := loopCount + 1.

	(self isInfinite or: [ loopCount < loop ])
		ifFalse: [ ^ false ].
	
	"If I am an infinite animation and loop limit is not hit
	we prepare ourselves for a next loop"
	self initStart.
	
	^ true