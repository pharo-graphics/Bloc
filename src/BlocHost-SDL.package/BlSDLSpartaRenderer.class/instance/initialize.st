initialization
initialize

	super initialize.
	session := Smalltalk session.
	spartaCanvas := nil.
	sdlSurface := nil.
	texture := nil.
	sdlRenderer := nil.
	self presentNeeded.