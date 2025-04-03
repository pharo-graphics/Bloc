Class {
	#name : #BlOSWindowSDL2HostSpace,
	#superclass : #BlOSWindowHostSpace,
	#instVars : [
		'sdlRenderer',
		'texture',
		'textureRectangle'
	],
	#pools : [
		'SDL2Constants'
	],
	#category : #'BlocHost-OSWindow-SDL2'
}

{ #category : #initialization }
BlOSWindowSDL2HostSpace >> initializeRenderer [

	| physicalExtent |
	super initializeRenderer.

	sdlRenderer := window backendWindow renderer sdlRenderer.
	physicalExtent := sdlRenderer outputExtent.
	textureRectangle := 0@0 extent: physicalExtent.

	texture := sdlRenderer
		createTextureFormat: SDL_PIXELFORMAT_XRGB8888
		access: SDL_TEXTUREACCESS_STREAMING
		width: physicalExtent x
		height: physicalExtent y.
]

{ #category : #rendering }
BlOSWindowSDL2HostSpace >> lockSurfaceFor: damagedRectangles scaleFactor: aNumber during: aBlock [

	| logicalDamagedRectangle damagedRectangle |
	"For now we only support a single rectangle"
	logicalDamagedRectangle := (Rectangle merging: damagedRectangles) expanded.
	
	damagedRectangle := logicalDamagedRectangle scaleBy: aNumber.
	damagedRectangle := damagedRectangle intersect: textureRectangle.

	"The only changed rectangle is outside of the window?"
	damagedRectangle isZero ifTrue: [ ^ self ].

 	ExternalAddress
		allocate: Smalltalk wordSize
		bytesDuring: [ :pitchAddress |
			| pixelsAddress |
			pixelsAddress := ExternalAddress new.

			(texture
				lockRect: damagedRectangle asSDLRect
				pixels: pixelsAddress 
				pitch: pitchAddress) = 0 ifFalse: [ SDL2 checkForError ].

			renderer
				renderWith: aBlock
				pixels: pixelsAddress
				stride: (pitchAddress signedLongAt: 1)
				physicalRectangle: damagedRectangle
				logicalRectangle: logicalDamagedRectangle.

			texture unlock ].

	"No need to clear the renderer as texture is opaque and covers all pixels"
	sdlRenderer copy: texture; present
]
