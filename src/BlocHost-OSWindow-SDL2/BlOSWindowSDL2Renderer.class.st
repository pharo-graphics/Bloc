"
I am an Bloc OSWindow renderer which uses SDL2.
"
Class {
	#name : #BlOSWindowSDL2Renderer,
	#superclass : #OSWindowRenderer,
	#instVars : [
		'sdlRenderer'
	],
	#pools : [
		'SDL2Constants'
	],
	#category : #'BlocHost-OSWindow-SDL2'
}

{ #category : #'instance creation' }
BlOSWindowSDL2Renderer class >> for: aSDL2BackendWindow [

	^ self basicNew
		initializeWith: aSDL2BackendWindow;
		yourself
]

{ #category : #'instance creation' }
BlOSWindowSDL2Renderer class >> new [ 
	self error: 'Use #for:'
]

{ #category : #'host space - accessing' }
BlOSWindowSDL2Renderer >> canvasExtent [

	^ sdlRenderer outputExtent
]

{ #category : #deleting }
BlOSWindowSDL2Renderer >> destroy [

	sdlRenderer destroy.
	super destroy.
]

{ #category : #'updating screen' }
BlOSWindowSDL2Renderer >> exposed [
]

{ #category : #initialization }
BlOSWindowSDL2Renderer >> initializeWith: aSDL2BackendWindow [

	self initialize.
	self backendWindow: aSDL2BackendWindow.
	sdlRenderer := aSDL2BackendWindow sdl2Window createAcceleratedRenderer
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

{ #category : #'updating screen' }
BlOSWindowSDL2Renderer >> resized [
	
]

{ #category : #accessing }
BlOSWindowSDL2Renderer >> sdlRenderer [

	^ sdlRenderer
]

{ #category : #'updating screen' }
BlOSWindowSDL2Renderer >> updateAll [
	self shouldNotImplement
]

{ #category : #'updating screen' }
BlOSWindowSDL2Renderer >> updateRectangle: aRectangle [
	self shouldNotImplement
]

{ #category : #'updating screen' }
BlOSWindowSDL2Renderer >> updateRectangles: allDamage [
	self shouldNotImplement
]
