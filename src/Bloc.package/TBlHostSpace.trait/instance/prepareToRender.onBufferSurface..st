host space - rendering
prepareToRender: aBlSpace onBufferSurface: aBlHostRendererBufferSurface
	"Prepare host space to a given space on a buffer surface.
	By default dispatch directly to the renderer"

	self renderer prepareToRender: aBlSpace