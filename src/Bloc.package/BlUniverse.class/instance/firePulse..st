pulse managing
firePulse: aPulseEvent
	[  
		self host pollEvents.
		self pulseRequested ifTrue:[
			nextPulseRequested := false.
			announcer announce: (aPulseEvent timestamp: Time millisecondClockValue).
			self animationManager pulse.
			self spaceManager pulse.
		].
		self tryToRunDeferredActions.
	
	] on: Error do: [ :err | 
		"It is critical, that event handling keep running despite errors.
		Normally, any errors in event handling requires immediate attention and fixing"
		err freeze.
		[ err debug ] fork.
	 ]