host space - rendering
render: aBlSpace onBufferSurface: aBlHostRendererBufferSurface
	"Render a given space on an a buffer surface.
	By default dispatch directly to the renderer"

	self renderer doRender: aBlSpace