loop process
firePulse
	pulseStartTime := Time millisecondClockValue.
	BlUniverse default firePulse: self pulseEvent.
	self wait.
	Processor yield