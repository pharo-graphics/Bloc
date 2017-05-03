instance creation
forDataOn: aRendererSurface
	<return: #SpartaCanvas>

	^ (self class environment at: #MozCanvas)
		createForData: aRendererSurface data
		type: (self class environment at: #MozBackendType) SKIA
		extent: aRendererSurface canvasExtent
		stride: aRendererSurface stride
		format: (self class environment at: #MozSurfaceFormat) B8G8R8A8