initialization
initialize
	super initialize.

	self initializeHandlers.
	self initializeActions.
	self initializeClientListener.
	self layout: BlFrameLayout new.

	zIndex := 1000.
	hasInformation := false