pulse managing
firePulse: aPulseEvent
	self pulseRequested ifTrue:[
		nextPulseRequested := false.
		announcer announce: (aPulseEvent timestamp: Time millisecondClockValue).
	].
	self tryToRunDeferredActions.
	
	