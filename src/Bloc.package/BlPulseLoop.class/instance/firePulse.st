loop process
firePulse
	pulseStartTime := DateAndTime now.
	self pulseEvent timestamp: pulseStartTime.
	BlUniverse default firePulse: self pulseEvent.
	self wait.
	Processor yield