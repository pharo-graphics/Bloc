*BlocHost-SDL
getRenderer
	^ self ffiCall: #( SDL_Renderer SDL_GetRenderer ( self ) )