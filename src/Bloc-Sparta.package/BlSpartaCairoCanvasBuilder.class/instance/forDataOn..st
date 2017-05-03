instance creation
forDataOn: aRendererSurface
	<return: #SpartaCanvas>

	^ #SpartaCairoCanvas asClass
		createForData: aRendererSurface data
		extent: aRendererSurface canvasExtent
		stride: aRendererSurface stride
		format: #SpartaCairoSurfaceFormat asClass CAIRO_FORMAT_ARGB32