updating resources
resetResources
	| windowSize extent |
	self checkSession.

	windowSize := self sdlSpace windowExtent.
	extent := self sdlSpace rendererExtent.
	scaleFactor := (extent / windowSize) asFloatPoint.
	SDL2 glSetSwapInterval: 1.
	self createSDLSurfaceWithExtent: extent.
	
	spartaCanvas := MozCanvas
		createForData: sdlSurface pixels
		type: MozBackendType SKIA
		extent: extent
		stride: sdlSurface pitch
		format: MozSurfaceFormat B8G8R8A8.
	spartaCanvas transform
			scaleBy: scaleFactor;
			apply.

	texture := sdlRenderer 
		createTextureFormat: SDL_PIXELFORMAT_XRGB8888 
		access: SDL_TEXTUREACCESS_STREAMING 
		width: extent x 
		height: extent y.
		
	textureExtent := extent.