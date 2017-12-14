initialization
initialize
	super initialize.
	
	self clipChildren: false.
	
	cursorElement := nil. "initialized lazyly"
	cursorPosition := 0