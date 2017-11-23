initialization
initialize
	super initialize.
	
	self clipChildren: false.
	
	cursor := nil. "initialized lazyly"
	
	self background: (Color gray alpha: 0.2)