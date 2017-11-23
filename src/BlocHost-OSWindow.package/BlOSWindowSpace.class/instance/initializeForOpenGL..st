initialization
initializeForOpenGL: anOpenGLSurface
	"Asks host space to initialize itself to be used together with an OpenGL surface.
	Default implementation simply connects renderer, host space and surface together"
	| glAttributes |
	
	glAttributes := OSWindowGLAttributes new.
	glAttributes redSize: 8.
	glAttributes greenSize: 8.
	glAttributes blueSize: 8.
	glAttributes stencilSize: 8.
	
	self initializeWithAttributes: ((self host createAttributesFor: self space) glAttributes: glAttributes).

	anOpenGLSurface hostSpace: self.
	anOpenGLSurface hostRenderer: self renderer.
	"anOpenGLSurface context: UFFIOpenGLContext new."

	self renderer surface: anOpenGLSurface.
	
	window newOpenGLRenderer