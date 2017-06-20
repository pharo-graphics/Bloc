host space - rendering
prepareToRender: aBlSpace onOpenGLSurface: aBlHostRendererOpenGLSurface
	"Prepare host space to a given space on an OpenGL surface.
	By default dispatch directly to the renderer"

	self renderer prepareToRender: aBlSpace