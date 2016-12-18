*BlocHost-SDL
getDisplayIndex

	^ self ffiCall: #( int SDL_GetWindowDisplayIndex( self ) )