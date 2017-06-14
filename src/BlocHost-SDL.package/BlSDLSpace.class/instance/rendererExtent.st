private - accessing
rendererExtent
	"Return the size of a window's underlying drawable in pixels.
	Returned extent may differ from #extent on high dpi (retina) displays"
	<return: #Point>
	| width height |
	
	width := FFIExternalArray newType: 'int' size: 1.
	height := FFIExternalArray newType: 'int' size: 1.
	sdlWindow getRendererSize: sdlWindow getRenderer w: width h: height.
	^ (width signedLongAt: 1) @ (height signedLongAt: 1)