scrolling
startScrollBy: aDistance from: aStart during: aDuration
	
	isFinished := false.
	
	startPosition := aStart.
	currentPosition := aStart.
	finalPosition := aStart + aDistance.
	
	startTime := DateAndTime millisecondClockValue.
	duration := aDuration.
	
	deceleration := 0.0.
	startVelocity := 0