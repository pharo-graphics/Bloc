private - updating resources
resetResources
	
	self checkSession.

	windowSize := morphicSpace windowExtent.
	
	externalForm ifNotNil: [ :aForm | aForm destroySurface ].
	externalForm := ExternalForm extent: windowSize depth: 32.
	externalForm allocateSpace.
	externalForm fillColor: Color transparent.

	spartaCanvas := MozCanvas
		createForData: externalForm pointer
		type: MozBackendType SKIA
		extent: externalForm extent
		stride: externalForm stride
		format: MozSurfaceFormat B8G8R8A8.