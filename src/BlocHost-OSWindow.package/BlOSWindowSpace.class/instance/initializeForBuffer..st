initialization
initializeForBuffer: aBufferSurface
	"Asks host space to initialize itself to be used together with a pixel buffer surface.
	Default implementation simply connects renderer, host space and surface together"

	self initializeWithAttributes: (self host createAttributesFor: self space).

	aBufferSurface hostSpace: self.
	aBufferSurface hostRenderer: self renderer.

	self renderer surface: aBufferSurface.
	window newBlocRenderer surface: aBufferSurface