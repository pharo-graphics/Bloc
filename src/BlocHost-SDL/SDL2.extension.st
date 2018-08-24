Extension { #name : #SDL2 }

{ #category : #'*BlocHost-SDL' }
SDL2 class >> glClear: flags [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
	^ self nbCall: #( void glClear ( int flags ) )
]

{ #category : #'*BlocHost-SDL' }
SDL2 class >> glClearColorR: r g: g b: b a: a [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
	^ self nbCall: #( void glClearColor ( float r, float g, float b, float a ) )
]

{ #category : #'*BlocHost-SDL' }
SDL2 class >> glDeleteContext: aContext [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
	^ self nbCall: #( void SDL_GL_DeleteContext ( SDL_GLContext aContext ) )
]

{ #category : #'*BlocHost-SDL' }
SDL2 class >> glScissorX: x y: y width: w height: h [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
	^ self nbCall: #( void glScissor (uint32 x, uint32 y, uint32 w, uint32 h) )
]

{ #category : #'*BlocHost-SDL' }
SDL2 class >> glSetSwapInterval: aNumber [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
	^ self nbCall: #( void SDL_GL_SetSwapInterval ( uint32 aNumber ) )
]

{ #category : #'*BlocHost-SDL' }
SDL2 class >> glViewportX: x y: y width: w height: h [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
	^ self nbCall: #( void glViewport (uint32 x, uint32 y, uint32 w, uint32 h) )
]

{ #category : #'*BlocHost-SDL' }
SDL2 class >> globalMouseState [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
	^ self nbCall: #( Uint32 SDL_GetGlobalMouseState ( nil , nil ) )
]

{ #category : #'*BlocHost-SDL' }
SDL2 class >> globalMouseStateX: x y: y [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
	^ self nbCall: #( Uint32 SDL_GetGlobalMouseState ( int* x , int* y ) )
]
