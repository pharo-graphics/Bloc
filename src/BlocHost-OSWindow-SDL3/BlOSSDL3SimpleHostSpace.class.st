Class {
	#name : #BlOSSDL3SimpleHostSpace,
	#superclass : #BlOSSDL3HostSpace,
	#instVars : [
		'logicalWindowRectangle',
		'pixelsAddress',
		'pitchHolder',
		'sdlRect',
		'sdlRenderer',
		'sdlTexture'
	],
	#category : #'BlocHost-OSWindow-SDL3'
}

{ #category : #initialization }
BlOSSDL3SimpleHostSpace >> initializeRenderer [

	| textureExtent |
	super initializeRenderer.

	pitchHolder := FFIInt32 newValueHolder.
	pixelsAddress := ExternalAddress newPointer.
	sdlRect := SDL_Rect new.

	sdlRenderer := osWindow backendWindow renderer sdlRenderer.
	logicalWindowRectangle := 0@0 extent: osWindow extent.

	textureExtent := osWindow canvasExtent.
	sdlTexture := sdlRenderer
		newTextureFormat: SDL_PIXELFORMAT_XRGB8888
		access: SDL_TEXTUREACCESS_STREAMING
		width: textureExtent x
		height: textureExtent y
]

{ #category : #rendering }
BlOSSDL3SimpleHostSpace >> lockSurfaceFor: logicalDamagedRectangle scaleFactor: aNumber during: aBlock [

	| physicalDamagedRectangle |
	"Return early if damages fall outside of the space"
	physicalDamagedRectangle :=
		logicalDamagedRectangle intersect: logicalWindowRectangle ifNone: [ ^ self ].
	physicalDamagedRectangle scaleBy: aNumber.

	sdlRect
		x: physicalDamagedRectangle left asInteger;
		y: physicalDamagedRectangle top asInteger;
		w: physicalDamagedRectangle width asInteger;
		h: physicalDamagedRectangle height asInteger.

	sdlTexture
		lockRect: sdlRect
		pixels: pixelsAddress
		pitch: pitchHolder.

	renderer
		renderWith: aBlock
		pixels: pixelsAddress
		stride: pitchHolder value
		physicalRectangle: physicalDamagedRectangle
		logicalRectangle: logicalDamagedRectangle.

	sdlTexture unlock.

	sdlRenderer
"		renderDrawColorR: 0 g: 0 b: 0 a: 0;
		renderClear;"
		renderTexture: sdlTexture srcrect: nil dstrect: nil;
		renderPresent
]
