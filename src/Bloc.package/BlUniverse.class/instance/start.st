accessing
start
	self pulseLoop start.
	self allSpacesDo: [ :aSpace | aSpace host isRunning ifFalse: [ aSpace host start ] ].
	self requestNextPulse