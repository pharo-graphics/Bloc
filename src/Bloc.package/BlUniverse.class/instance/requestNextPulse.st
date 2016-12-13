pulse managing
requestNextPulse
	self flag: #'warningMayNeedsToBeThreadSafe'.
	self pulseLoop isRunning not ifTrue: [ self pulseLoop start ].
	nextPulseRequested := true