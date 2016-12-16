initialization
initialize
	super initialize.
	inputSemaphore := Semaphore new.
	hostSpaces := WeakValueDictionary new.
	eventHandler := BlSDLEventHandler new