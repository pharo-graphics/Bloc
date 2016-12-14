*BlocHost-SDL
raiseWindow
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
	^ self nbCall: #( void SDL_RaiseWindow( self ) )