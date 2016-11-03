updating resources
resetResources
	| extent |
	self checkSession.
	extent := self window extent.
	self createSDLSurfaceWithExtent: extent.
	spartaCanvas := MozCanvas
		createForData: sdlSurface pixels
		extent: sdlSurface w @ sdlSurface h
		stride: sdlSurface pitch
		format: MozSurfaceFormat B8G8R8A8.
	texture := renderer 
		createTextureFormat: SDL_PIXELFORMAT_XRGB8888 
		access: SDL_TEXTUREACCESS_STREAMING 
		width: extent x 
		height: extent y.
	textureExtent := extent.