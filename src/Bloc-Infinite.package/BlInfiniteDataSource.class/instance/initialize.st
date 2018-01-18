initialization
initialize
	super initialize.
	
	eventDispatcher := BlDirectEventDispatcher on: self.
	hasStableIds := false