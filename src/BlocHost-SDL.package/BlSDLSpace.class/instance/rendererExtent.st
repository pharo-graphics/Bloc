private - accessing
rendererExtent
	"Return the size of a window's underlying drawable in pixels.
	Returned extent may differ from #extent on high dpi (retina) displays"
	<return: #Point>
	| width height |
	
	width := FFIExternalArray externalNewType: 'int' size: 1.
	height := FFIExternalArray externalNewType: 'int' size: 1.
	sdlWindow
		getRendererSize: sdlWindow getRenderer
		w: width getHandle
		h: height getHandle.
	^ (width at: 1) @ (height at: 1)