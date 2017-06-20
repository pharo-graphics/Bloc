host space - accessing
canvasExtent
	| width height extent |

	width := FFIExternalArray externalNewType: 'int' size: 1.
	height := FFIExternalArray externalNewType: 'int' size: 1.

	window handle
		osWindowHostGetRendererSize: window handle osWindowHostGetRenderer
		width: width getHandle
		height: height getHandle.
	extent := (width at: 1) @ (height at: 1).

	width free.
	height free.
	
	^ extent