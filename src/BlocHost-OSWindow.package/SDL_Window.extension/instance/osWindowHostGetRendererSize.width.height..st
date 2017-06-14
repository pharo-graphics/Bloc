*BlocHost-OSWindow
osWindowHostGetRendererSize: aSDLRenderer width: aWidth height: aHeight
	^ self ffiCall: #( void SDL_GetRendererOutputSize (
		SDL_Renderer aSDLRenderer,
		int* aWidth,
		int* aHeight ) )