instance creation
forOpenGLOn: aRendererSurface
	<return: #SpartaCanvas>
	
	^ (self class environment at: #SkiaCanvas)
		extent: aRendererSurface windowExtent
		renderExtent: aRendererSurface canvasExtent