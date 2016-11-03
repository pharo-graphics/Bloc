initialization
initialize
	super initialize.
	hostSpaces := WeakValueDictionary new.
	eventHandler := BlSDLEventHandler new