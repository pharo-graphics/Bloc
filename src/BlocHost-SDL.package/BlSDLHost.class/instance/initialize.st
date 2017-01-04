initialization
initialize
	super initialize.
	
	inputSemaphore := Semaphore new.
	
	hostSpaces := nil. "initialized in #start"
	eventHandler := nil "initialized in #start"