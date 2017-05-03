initialization
initializeResourcesOn: aHostRenderer
	externalForm := BlExternalForm extent: self canvasExtent depth: 32.
	externalForm allocateSpace.
	externalForm fillColor: Color transparent.

	aHostRenderer initializeFormOn: self