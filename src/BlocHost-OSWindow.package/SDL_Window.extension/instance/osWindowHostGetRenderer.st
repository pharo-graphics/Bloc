*BlocHost-OSWindow
osWindowHostGetRenderer
	^ self ffiCall: #( SDL_Renderer SDL_GetRenderer ( self ) )