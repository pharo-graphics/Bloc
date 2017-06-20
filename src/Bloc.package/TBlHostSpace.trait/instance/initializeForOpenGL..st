initialization
initializeForOpenGL: anOpenGLSurface
	"Asks host space to initialize itself to be used together with an OpenGL surface.
	Default implementation simply connects renderer, host space and surface together"

	anOpenGLSurface hostSpace: self.
	anOpenGLSurface hostRenderer: self renderer.

	self renderer surface: anOpenGLSurface