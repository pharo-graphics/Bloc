running
setUp
	super setUp.
	
	parent := BlElement new.
	parent layout: BlFrameLayout new.
	
	child := BlElement new.
	
	parent addChild: child