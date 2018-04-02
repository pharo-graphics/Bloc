initialize-release
initialize
	super initialize.
	announcer := Announcer new.
	deferredActions := WaitfreeQueue new.
	pulseListeners := OrderedCollection new.
	pulseLoop := self defaultPulseLoop.
	nextPulseRequested :=true.
	spaceManager := BlSpaceManager new