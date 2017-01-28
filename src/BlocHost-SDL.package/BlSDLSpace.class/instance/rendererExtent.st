private - accessing
rendererExtent
	"Return the size of a window's underlying drawable in pixels.
	Returned extent may differ from #extent on high dpi (retina) displays"
	<return: #Point>
	| w h |
	
	w := ByteArray new: ExternalType long byteSize.
	h := ByteArray new: ExternalType long byteSize.
	sdlWindow getRendererSize: sdlWindow getRenderer w: w h: h.
	^ (w signedLongAt: 1) @ (h signedLongAt: 1)