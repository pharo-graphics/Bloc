*BlocHost-SDL
glSetSwapInterval: aNumber
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
	^ self nbCall: #( void SDL_GL_SetSwapInterval ( uint32 aNumber ) )