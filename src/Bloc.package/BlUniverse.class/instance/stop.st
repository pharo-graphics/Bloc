life cycle
stop
	pulseListeners do: [ :each | each clear ].
	self pulseLoop stop.
	