initialization
initialize
	super initialize.
	
	form := BlExternalForm extent: 1@1 depth: 32.
	form autoRelease.
	form allocateSpace.
	form fillColor: Color transparent.
	color := Color transparent.
	defered := false