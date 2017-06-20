initialization
initializeForForm: anFormSurface
	"Asks host space to initialize itself to be used together with a Form surface.
	Default implementation simply connects renderer, host space and surface together"
	
	self initializeWithAttributes: (self host createAttributesFor: self space).
	
	anFormSurface hostSpace: self.
	anFormSurface hostRenderer: self renderer.

	self renderer surface: anFormSurface.
	window newBlocRenderer surface: anFormSurface