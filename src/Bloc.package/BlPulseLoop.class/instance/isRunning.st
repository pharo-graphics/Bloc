testing
isRunning
	^ loopProcess isNotNil and: [ loopProcess isTerminated not ]