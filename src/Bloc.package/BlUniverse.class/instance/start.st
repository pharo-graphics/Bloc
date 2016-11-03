life cycle
start
	self host start.
	self pulseLoop isRunning not
		ifTrue: [ self pulseLoop launch ].
	