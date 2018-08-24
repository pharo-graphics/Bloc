"
I am an Bloc OSWindow renderer which uses SDL2.
"
Class {
	#name : #BlOSWindowSDL2Renderer,
	#superclass : #BlOSWindowRenderer,
	#instVars : [
		'texture',
		'renderer',
		'textureExtent',
		'sdlSurface'
	],
	#pools : [
		'SDL2Constants'
	],
	#category : 'BlocHost-OSWindow-Support'
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
	super destroy.
	
	texture := nil.
	renderer := nil.
	sdlSurface := nil
]

{ #category : #initialization }
BlOSWindowSDL2Renderer >> initialize [
	super initialize.

	texture := nil.
	renderer := nil.
	sdlSurface := nil
]

{ #category : #initialization }
BlOSWindowSDL2Renderer >> initializeForBuffer: aBlHostRendererBufferSurface [
	
	self
		assert: [ self window isNotNil ]
		description: [ 'Window must be set!' ].
	
	textureExtent := aBlHostRendererBufferSurface canvasExtent.
	sdlSurface := SDL2 createRGBSurfaceForCairoWidth: textureExtent x height: textureExtent y.

	texture := renderer
		createTextureFormat: SDL_PIXELFORMAT_XRGB8888 
		access: SDL_TEXTUREACCESS_STREAMING
		width: textureExtent x
		height: textureExtent y.

	aBlHostRendererBufferSurface
		buffer: sdlSurface pixels;
		stride: sdlSurface pitch;
		extent: textureExtent
]

{ #category : #initialization }
BlOSWindowSDL2Renderer >> initializeForForm: aBlHostRendererBufferSurface [

	self
		assert: [ self window isNotNil ]
		description: [ 'Window must be set!' ].
	
	textureExtent := aBlHostRendererBufferSurface canvasExtent.
	
	texture := renderer
		createTextureFormat: SDL_PIXELFORMAT_XRGB8888 
		access: SDL_TEXTUREACCESS_STREAMING
		width: textureExtent x
		height: textureExtent y
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
	
	self
		assert: [ renderer isNotNil ]
		description: [ 'Renderer mut not be nil' ].
	
	self
		assert: [ texture isNotNil ]
		description: [ 'Texture mut not be nil' ].

	renderer
		clear;
		copy: texture;
		present
]

{ #category : #'updating screen' }
BlOSWindowSDL2Renderer >> presentBufferSurface: aBlHostRendererBufferSurface areas: aCollectionOfAreas [
	[ 
		| pitchHolder pixels pitch destinationForm sourceForm aWindowScale dirtyAreas |
		pixels := ExternalAddress new.
		pitchHolder := FFIExternalArray externalNewType: 'int' size: 1.
		[
			texture lockPixels: pixels pitch: pitchHolder getHandle.
			pitch := pitchHolder at: 1.
		] ensure: [ pitchHolder free ].

		destinationForm := BlExternalForm extent: textureExtent depth: 32 bits: pixels.
		sourceForm := BlExternalForm extent: aBlHostRendererBufferSurface extent depth: 32 bits: aBlHostRendererBufferSurface buffer.
		
		"Damaged rectangles are defined in user coordinates (bloc space).
		We have to convert damage to window space, since we want to support high dpi displays"
		aWindowScale := aBlHostRendererBufferSurface scaleFactor.
		dirtyAreas := aCollectionOfAreas collect: [ :aRectangle | aRectangle scaleBy: aWindowScale ].
		dirtyAreas do: [ :rectangle |
			destinationForm copy: rectangle from: sourceForm to: rectangle origin rule: Form over ].
	]
	ensure: [
		texture unlock.
	].

	self present
]

{ #category : #'updating screen' }
BlOSWindowSDL2Renderer >> presentFormSurface: aBlHostRendererFormSurface areas: aCollectionOfAreas [
	[ 
		| pitchHolder pixels pitch destinationForm aWindowScale dirtyAreas |
		pixels := ExternalAddress new.
		pitchHolder := FFIExternalArray externalNewType: 'int' size: 1.
		[
			texture lockPixels: pixels pitch: pitchHolder getHandle.
			pitch := pitchHolder at: 1.
		] ensure: [ pitchHolder free ].

		destinationForm := BlExternalForm extent: textureExtent depth: 32 bits: pixels.
		
		"Damaged rectangles are defined in user coordinates (bloc space).
		We have to convert damage to window space, since we want to support high dpi displays"
		aWindowScale := aBlHostRendererFormSurface scaleFactor.
		dirtyAreas := aCollectionOfAreas collect: [ :aRectangle | aRectangle scaleBy: aWindowScale ].
		dirtyAreas do: [ :rectangle |
			destinationForm copy: rectangle from: aBlHostRendererFormSurface form to: rectangle origin rule: Form over ].
	] ensure: [ texture unlock ].

	self present
]
