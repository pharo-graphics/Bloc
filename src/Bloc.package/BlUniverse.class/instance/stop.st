accessing
stop
	pulseListeners do: [ :each | each clear ].
	self pulseLoop isRunning ifTrue:[self pulseLoop stop].
	self host stop.