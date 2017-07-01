tests
testEnqueueEvent

	space pulse.
	self assert: space pulseRequested not.
	
	space hostSpace enqueueEvent: (BlMouseMoveEvent new position: 20@20).
	self assert: space pulseRequested.
	
	space pulse.
	self assert: space pulseRequested not