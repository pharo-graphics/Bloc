loop process
firePulse
	(session == Smalltalk session)
		ifFalse: [ ^ self stop ].
		
	pulseStartTime := Time millisecondClockValue.
	BlUniverse default firePulse: self pulseEvent.
	self wait.
	Processor yield