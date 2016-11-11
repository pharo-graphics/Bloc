adding
computeElapsedTime
	^ (Time millisecondClockValue - (startTime + delay)) min: self duration