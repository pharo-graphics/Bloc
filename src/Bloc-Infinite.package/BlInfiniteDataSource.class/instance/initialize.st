initialization
initialize
	super initialize.
	
	eventDispatcher := BlSimpleEventDispatcher new.
	hasStableIds := false