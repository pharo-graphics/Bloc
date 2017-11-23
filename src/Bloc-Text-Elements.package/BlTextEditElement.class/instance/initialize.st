initialization
initialize
	super initialize.
	
	self clipChildren: false.
	
	cursor := nil. "initialized lazyly"