initialization
initialize
	super initialize.
	isRunning := false.
	hostSpaces := nil. "initialized in #start"
	eventHandler := nil "initialized in #start"