pulse managing
requestNextPulse
	self flag: #'warningMayNeedsToBeThreadSafe'.
	self start.
	nextPulseRequested := true