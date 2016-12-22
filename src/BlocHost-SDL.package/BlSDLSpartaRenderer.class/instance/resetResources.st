updating resources
resetResources
	| windowSize extent |
	self checkSession.

	windowSize := self sdlSpace windowExtent.
	extent := self sdlSpace extent.
	self createSDLSurfaceWithExtent: extent.
	spartaCanvas := MozCanvas
		createForData: sdlSurface pixels
		extent: extent
		stride: sdlSurface pitch
		format: MozSurfaceFormat B8G8R8A8.
	spartaCanvas transform
			scaleBy: (extent / windowSize) asFloatPoint;
			apply.
	texture := sdlRenderer 
		createTextureFormat: SDL_PIXELFORMAT_XRGB8888 
		access: SDL_TEXTUREACCESS_STREAMING 
		width: extent x 
		height: extent y.
		
	textureExtent := extent.