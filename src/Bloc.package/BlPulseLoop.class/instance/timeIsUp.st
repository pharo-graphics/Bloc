period
timeIsUp
	^ pulseStartTime isNotNil
		and: [ Time millisecondClockValue - pulseStartTime > self pulsePeriod ]