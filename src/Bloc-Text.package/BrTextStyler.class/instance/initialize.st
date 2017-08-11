initialization
initialize
	super initialize.
	
	stylingEnabled := true.
	eventDispatcher := BlBubblingEventDispatcher on: self