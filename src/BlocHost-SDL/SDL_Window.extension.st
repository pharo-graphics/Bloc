Extension { #name : #'SDL_Window' }

{ #category : #'*BlocHost-SDL' }
SDL_Window >> getDisplay: anIndex ddpi: ddpi hdpi: hdpi vdpi: vdpi [

	^ self ffiCall: #( void SDL_GetDisplayDPI ( int anIndex , float* ddpi , float* hdpi, float* vdpi ) )
]

{ #category : #'*BlocHost-SDL' }
SDL_Window >> getDisplayIndex [

	^ self ffiCall: #( int SDL_GetWindowDisplayIndex( self ) )
]

{ #category : #'*BlocHost-SDL' }
SDL_Window >> getDrawableSize: aSDLWindow w: w h: h [
	^ self ffiCall: #( void SDL_GL_GetDrawableSize ( SDL_Window aSDLWindow , int* w , int* h ) )
]

{ #category : #'*BlocHost-SDL' }
SDL_Window >> getRenderer [
	^ self ffiCall: #( SDL_Renderer SDL_GetRenderer ( self ) )
]

{ #category : #'*BlocHost-SDL' }
SDL_Window >> getRendererSize: aSDLRenderer w: w h: h [
	^ self ffiCall: #( void SDL_GetRendererOutputSize ( SDL_Renderer aSDLRenderer , int* w , int* h ) )
]

{ #category : #'*BlocHost-SDL' }
SDL_Window >> raiseWindow [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
	^ self nbCall: #( void SDL_RaiseWindow( self ) )
]
