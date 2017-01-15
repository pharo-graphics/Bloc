*BlocHost-SDL
glDeleteContext: aContext
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
	^ self nbCall: #( void SDL_GL_DeleteContext ( SDL_GLContext aContext ) )