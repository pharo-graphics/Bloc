as yet unclassified
stepService
	(session == Smalltalk session) ifFalse:[^ self kill].
	pulseStartTime := Time millisecondClockValue.
	BlUniverse default firePulse: self pulseEvent.
	self wait.
	Processor yield