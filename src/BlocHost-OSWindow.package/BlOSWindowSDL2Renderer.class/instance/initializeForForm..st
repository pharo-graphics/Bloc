initialization
initializeForForm: aBlHostRendererBufferSurface

	self
		assert: [ self window isNotNil ]
		description: [ 'Window must be set!' ].
	
	textureExtent := aBlHostRendererBufferSurface canvasExtent.
	
	texture := renderer
		createTextureFormat: SDL_PIXELFORMAT_XRGB8888 
		access: SDL_TEXTUREACCESS_STREAMING
		width: textureExtent x
		height: textureExtent y