*BlocHost-SDL
getRendererSize: aSDLRenderer w: w h: h
	^ self ffiCall: #( void SDL_GetRendererOutputSize ( SDL_Renderer aSDLRenderer , int* w , int* h ) )