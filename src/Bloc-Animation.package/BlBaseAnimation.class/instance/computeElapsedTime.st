time management
computeElapsedTime
	^ (DateAndTime now - self delayedStartTime) min: self duration