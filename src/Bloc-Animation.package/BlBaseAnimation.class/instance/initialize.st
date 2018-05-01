initialization
initialize
	super initialize.
	
	actionHandlers := OrderedCollection new.
	eventDispatcher := BlDirectEventDispatcher on: self.
	
	delay := 0 milliSeconds. "configurable"
	loop := 1. "configurable"
	
	time := BlTime real.

	self reset.
	