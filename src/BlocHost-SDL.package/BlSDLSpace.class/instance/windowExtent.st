host space - accessing
windowExtent
	"Return the window size in screen coordinates.
	This size may differ from the size in pixels on high dpi (retina) screens.
	Use #extent to get actual pixel size"
	<return: #Point>
	| w h |

	w := ByteArray new: ExternalType long byteSize.
	h := ByteArray new: ExternalType long byteSize.
	sdlWindow getSizeW: w h: h.
	^ (w signedLongAt: 1) @ (h signedLongAt: 1)