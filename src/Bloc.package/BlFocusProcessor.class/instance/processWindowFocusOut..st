focus request
processWindowFocusOut: anEvent
	|evt|
	self space ungrabFocus.
	
	evt := BlBaseFocusEvent new
		target: lastFocusOwner;
		yourself.
		
	self processBlur: evt.