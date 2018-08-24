Extension { #name : #OSSDL2GLRenderer }

{ #category : #'*BlocHost-OSWindow' }
OSSDL2GLRenderer >> canvasExtent [
	| width height extent |

	width := FFIExternalArray externalNewType: 'int' size: 1.
	height := FFIExternalArray externalNewType: 'int' size: 1.

	window handle
		osWindowHostGetDrawableSizeWidth: width getHandle
		height: height getHandle.
	extent := (width at: 1) @ (height at: 1).

	width free.
	height free.
	
	^ extent
]
