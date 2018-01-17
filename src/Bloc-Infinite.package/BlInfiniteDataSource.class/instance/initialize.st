initialization
initialize
	super initialize.
	
	eventDispatcher := BlDirectEventDispatcher new.
	hasStableIds := false