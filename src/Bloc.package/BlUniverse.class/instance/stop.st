life cycle
stop
	pulseListeners do: [ :each | each clear ].
	self pulseLoop isRunning ifTrue:[self pulseLoop kill].
	self host stop.