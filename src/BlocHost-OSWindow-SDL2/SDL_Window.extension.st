Extension { #name : #'SDL_Window' }

{ #category : #'*BlocHost-OSWindow-SDL2' }
SDL_Window >> osWindowHostGetDrawableSizeWidth: aWidth height: aHeight [
	^ self ffiCall: #( void SDL_GL_GetDrawableSize ( self , int* aWidth , int* aHeight ) )
]

{ #category : #'*BlocHost-OSWindow-SDL2' }
SDL_Window >> osWindowHostGetRendererSize: aSDLRenderer width: aWidth height: aHeight [
	^ self ffiCall: #( void SDL_GetRendererOutputSize (
		SDL_Renderer aSDLRenderer,
		int* aWidth,
		int* aHeight ) )
]
