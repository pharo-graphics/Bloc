instance creation
forFormOn: aRendererSurface
	<return: #SpartaCanvas>

	^ (self class environment at: #MozCanvas)
		createForData: aRendererSurface pointer
		type: (self class environment at: #MozBackendType) SKIA
		extent: aRendererSurface extent
		stride: aRendererSurface stride
		format: (self class environment at: #MozSurfaceFormat) B8G8R8A8