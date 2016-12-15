focus request
processWindowFocusIn: anEvent
	|evt|
	self space grabFocus.
	
	lastFocusOwner ifNil:[ ^ self].
	evt := BlBaseFocusEvent new
		target: lastFocusOwner;
		yourself.
	self processFocus: evt.