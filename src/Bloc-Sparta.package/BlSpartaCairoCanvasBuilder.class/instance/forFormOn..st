instance creation
forFormOn: aRendererSurface
	<return: #SpartaCanvas>

	^ (self class environment at: #SpartaCairoCanvas)
		createForData: aRendererSurface pointer
		extent: aRendererSurface extent
		stride: aRendererSurface stride
		format: #SpartaCairoSurfaceFormat asClass CAIRO_FORMAT_ARGB32