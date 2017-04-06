initialization
initialize
	super initialize.
	
	self addEventHandler: self defaultTextEditListener.
	self mouseCursor: BlCursor overEditableText.
	
	cursors := OrderedCollection new.
	self clipChildren: false.
	