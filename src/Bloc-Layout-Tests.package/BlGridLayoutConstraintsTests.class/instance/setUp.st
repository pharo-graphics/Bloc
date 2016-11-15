running
setUp
	super setUp.
	
	parent := BlElement new.
	parent layout: BlGridLayout horizontal.
	
	child := BlElement new.
	
	parent addChild: child