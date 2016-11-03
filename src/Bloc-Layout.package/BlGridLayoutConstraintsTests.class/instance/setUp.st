running
setUp
	super setUp.
	
	parent := BlElement new.
	parent layout: BlGridLayout new.
	
	child := BlElement new.
	
	parent addChild: child