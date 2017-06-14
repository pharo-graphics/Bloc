initialization
initializeResourcesOn: aHostRenderer
	externalForm := BlExternalForm extent: self canvasExtent depth: 32.
	externalForm autoRelease.
	externalForm allocateSpace.
	externalForm fillColor: Color transparent.

	aHostRenderer initializeForForm: self