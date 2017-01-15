*BlocHost-SDL
glClearColorR: r g: g b: b a: a
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
	^ self nbCall: #( void glClearColor ( float r, float g, float b, float a ) )