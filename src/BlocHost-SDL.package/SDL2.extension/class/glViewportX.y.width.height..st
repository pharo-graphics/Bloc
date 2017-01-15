*BlocHost-SDL
glViewportX: x y: y width: w height: h
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
	^ self nbCall: #( void glViewport (uint32 x, uint32 y, uint32 w, uint32 h) )