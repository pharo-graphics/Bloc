accessing
extendDuration: anExtendDuration
	| aTime anElapsedTime |
	
	aTime := DateAndTime millisecondClockValue.
	anElapsedTime := aTime - startTime.
	duration := anElapsedTime + anExtendDuration.
	isFinished := false