loop process
createLoopTask
	^ [[ self firePulse;wait.
	Processor yield ] repeat. ]