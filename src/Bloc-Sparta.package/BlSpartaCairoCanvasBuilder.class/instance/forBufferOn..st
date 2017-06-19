instance creation
forBufferOn: aRendererSurface
	<return: #SpartaCanvas>

	^ (self class environment at: #SpartaCairoCanvas)
		createForData: aRendererSurface buffer
		extent: aRendererSurface extent
		stride: aRendererSurface stride
		format: (self class environment at: #SpartaCairoSurfaceFormat) CAIRO_FORMAT_ARGB32