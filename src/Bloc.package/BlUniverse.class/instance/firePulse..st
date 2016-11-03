pulse managing
firePulse: aPulseEvent
	self host pollEvents.
	self pulseRequested ifTrue:[
		nextPulseRequested := false.
		announcer announce: (aPulseEvent timestamp: Time millisecondClockValue).
		self animationManager pulse.
		self spaceManager pulse.
	].
	self tryToRunDeferredActions.
	
	