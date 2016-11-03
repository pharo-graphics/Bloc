focus request
processWindowFocusOut: anEvent
	|evt|
	evt := BlBaseFocusEvent new
		target: lastFocusOwner;
		yourself.
		
	self processBlur: evt.