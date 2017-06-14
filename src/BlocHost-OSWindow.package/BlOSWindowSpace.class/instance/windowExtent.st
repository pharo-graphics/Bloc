host space - accessing
windowExtent
	"Return the window size in screen coordinates.
	This size may differ from the size in pixels of underlying surface 
	on high dpi (retina) screens"
	<return: #Point>
	| width height extent |

	width := FFIExternalArray externalNewType: 'int' size: 1.
	height := FFIExternalArray externalNewType: 'int' size: 1.
	
	window handle handle getSizeW: width h: height.
	extent := (width at: 1) @ (height at: 1).

	width free.
	height free.
	
	^ extent