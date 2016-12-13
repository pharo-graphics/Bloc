pulse managing
requestNextPulse
	self flag: #'warningMayNeedsToBeThreadSafe'.
	nextPulseRequested := true