initialization
initializeForBuffer: aBlHostRendererBufferSurface
	
	self
		assert: [ self window isNotNil ]
		description: [ 'Window must be set!' ].
	
	textureExtent := aBlHostRendererBufferSurface canvasExtent.
	sdlSurface := SDL2 createRGBSurfaceForCairoWidth: textureExtent x height: textureExtent y.

	texture := renderer
		createTextureFormat: SDL_PIXELFORMAT_XRGB8888 
		access: SDL_TEXTUREACCESS_STREAMING
		width: textureExtent x
		height: textureExtent y.

	aBlHostRendererBufferSurface
		buffer: sdlSurface pixels;
		stride: sdlSurface pitch;
		extent: textureExtent