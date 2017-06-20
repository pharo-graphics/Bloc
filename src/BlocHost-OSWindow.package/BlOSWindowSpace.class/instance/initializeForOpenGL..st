initialization
initializeForOpenGL: anOpenGLSurface
	"Asks host space to initialize itself to be used together with an OpenGL surface.
	Default implementation simply connects renderer, host space and surface together"

	self initializeWithAttributes: ((self host createAttributesFor: self space) glAttributes: UFFIOpenGLContext glAttributes).

	anOpenGLSurface hostSpace: self.
	anOpenGLSurface hostRenderer: self renderer.
	anOpenGLSurface context: UFFIOpenGLContext new.

	self renderer surface: anOpenGLSurface.
	
	window newOpenGLRenderer