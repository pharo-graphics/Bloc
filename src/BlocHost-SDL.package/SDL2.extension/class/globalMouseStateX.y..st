*BlocHost-SDL
globalMouseStateX: x y: y
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
	^ self nbCall: #( Uint32 SDL_GetGlobalMouseState ( int* x , int* y ) )