running
setUp
	super setUp.
	
	parent := BlElement new.
	parent layout: BlLinearLayout vertical.
	
	child := BlElement new.
	
	parent addChild: child