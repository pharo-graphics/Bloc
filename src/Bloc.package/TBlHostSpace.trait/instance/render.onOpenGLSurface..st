host space - rendering
render: aBlSpace onOpenGLSurface: aBlHostRendererOpenGLSurface
	"Render a given space on an OpenGL surface.
	By default dispatch directly to the renderer"

	self renderer doRender: aBlSpace