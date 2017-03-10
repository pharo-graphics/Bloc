private
createSDLSurfaceWithExtent: extent
	surfaceForm ifNotNil: [ surfaceForm destroySurface ].
	sdlSurface := SDL2 createRGBSurfaceForCairoWidth: extent x height: extent y.
	surfaceForm := SpartaExternalForm extent: extent depth: 32 bits: sdlSurface pixels.