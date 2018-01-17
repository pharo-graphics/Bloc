pulse managing
firePulse: aPulseEvent
	[  
		nextPulseRequested := false.
		announcer announce: aPulseEvent.
		self animationManager pulse.
		self spaceManager pulse.
		self tryToRunDeferredActions.
	] on: Error do: [ :err | 
		"It is critical, that event handling keeps running despite errors.
		Normally, any errors in event handling requires immediate attention and fixing"
		err freeze.
		[ err debug ] fork.
	 ]