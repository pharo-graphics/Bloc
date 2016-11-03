api
createHostSpaceFor: aSpace
	| sdlWin hostSpace|
	sdlWin := self createSDLWindowFor: aSpace.
	hostSpace := BlSDLSpace new 
		sdlWindow: sdlWin;
		withSpartaRendereer.
	self registerHostSpace: hostSpace.
	aSpace hostSpace: hostSpace