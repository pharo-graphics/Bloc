*BlocHost-SDL
glClear: flags
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
	^ self nbCall: #( void glClear ( int flags ) )