*BlocHost-SDL
globalMouseState
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
	^ self nbCall: #( Uint32 SDL_GetGlobalMouseState ( nil , nil ) )