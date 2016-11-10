accessing
start
	self host start.
	self pulseLoop isRunning not
		ifTrue: [ self pulseLoop start ].
	