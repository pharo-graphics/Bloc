"
I am an Bloc OSWindow renderer which uses SDL2.
"
Class {
	#name : #BlOSWindowSDL2Renderer,
	#superclass : #BlOSWindowRenderer,
	#instVars : [
		'renderer'
	],
	#pools : [
		'SDL2Constants'
	],
	#category : #'BlocHost-OSWindow-SDL2-Renderer'
}

{ #category : #'instance creation' }
BlOSWindowSDL2Renderer class >> for: aWindowHandle [
	^ self basicNew
		initialize;
		initializeWindowHandle: aWindowHandle;
		yourself
]

{ #category : #'instance creation' }
BlOSWindowSDL2Renderer class >> new [ 
	self error: 'Use #for:'
]

{ #category : #'host space - accessing' }
BlOSWindowSDL2Renderer >> canvasExtent [
	| width height extent |

	width := FFIExternalArray externalNewType: 'int' size: 1.
	height := FFIExternalArray externalNewType: 'int' size: 1.

	window handle
		osWindowHostGetRendererSize: window handle osWindowHostGetRenderer
		width: width getHandle
		height: height getHandle.
	extent := (width at: 1) @ (height at: 1).

	width free.
	height free.
	
	^ extent
]

{ #category : #deleting }
BlOSWindowSDL2Renderer >> destroy [
	super destroy
]

{ #category : #initialization }
BlOSWindowSDL2Renderer >> initialize [
	super initialize
]

{ #category : #initialization }
BlOSWindowSDL2Renderer >> initializeWindowHandle: aWindowHandle [

	self window: aWindowHandle.
	renderer := window handle createRenderer: -1 flags: SDL_RENDERER_ACCELERATED
]

{ #category : #'updating screen' }
BlOSWindowSDL2Renderer >> present [
	"SDL's rendering functions operate on a backbuffer; that is, calling a rendering function such as SDL_RenderDrawLine() does not directly put a line on the screen,
	but rather updates the backbuffer. As such, you compose your entire scene and present the composed backbuffer to the screen as a complete picture.
	Therefore, when using SDL's rendering API, one does all drawing intended for the frame, and then calls this function once per frame to present the final drawing to the user.
	The backbuffer should be considered invalidated after each present; do not assume that previous contents will exist between frames.
	You are strongly encouraged to call SDL_RenderClear() to initialize the backbuffer before starting each new frame's drawing, even if you plan to overwrite every pixel
	https://wiki.libsdl.org/SDL_RenderPresent?highlight=%28%5CbCategoryRender%5Cb%29%7C%28CategoryEnum%29%7C%28CategoryStruct%29"
	
	
]

{ #category : #accessing }
BlOSWindowSDL2Renderer >> renderer [
	^ renderer
]
