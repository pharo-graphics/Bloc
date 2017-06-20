initialization
initializeForOpenGL: anOpenGLSurface
	"Asks renderer to initialize itself to be used together with an OpenGL surface"
	| scaleFactor |

	windowExtent := anOpenGLSurface windowExtent.
	canvasExtent := anOpenGLSurface canvasExtent.

	scaleFactor := anOpenGLSurface scaleFactor.
	spartaCanvas := self class defaultCanvasBuilder forOpenGLOn: anOpenGLSurface.
	self
		assert: [ spartaCanvas isValid ]
		description: [ 'Failed to create sparta canvas' ].

	spartaCanvas transform
		scaleBy: scaleFactor;
		apply