initialization
initialize
	super initialize.
	
	form := BlExternalForm extent: 1@1 depth: 32.
	form autoRelease.
	color := Color transparent.
	defered := false