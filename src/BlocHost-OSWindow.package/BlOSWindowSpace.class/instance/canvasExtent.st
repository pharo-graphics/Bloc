host space - accessing
canvasExtent
	"Return a window canvas size in user coordinates.
	This size may differ from the window size on high dpi (retina) screens.
	In most cases canvas is x2 larger than window in pixel on retina screens."
	<return: #Point>
	| width height extent |

	width := FFIExternalArray externalNewType: 'int' size: 1.
	height := FFIExternalArray externalNewType: 'int' size: 1.

	window handle handle
		getRendererSize: window handle handle osWindowHostGetRenderer
		w: width getHandle
		h: height getHandle.
	extent := (width at: 1) @ (height at: 1).

	width free.
	height free.
	
	^ extent