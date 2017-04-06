initialization
initialize
	super initialize.

	self initializeHandlers.
	self initializeActions.
	self initializeClientListener.
	
	self padding: (BlInsets all: 5).
	zIndex := 1000