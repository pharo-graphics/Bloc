initialization
initialize
	super initialize.
	
	self addEventHandler: self defaultTextEditListener.
	self mouseCursor: BlCursor overEditableText.

	self clipChildren: false.
	
	cursor := nil "initialized lazyly"