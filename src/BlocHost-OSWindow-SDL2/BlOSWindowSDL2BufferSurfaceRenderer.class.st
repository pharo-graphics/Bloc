Class {
	#name : #BlOSWindowSDL2BufferSurfaceRenderer,
	#superclass : #BlHostSurfaceRenderer,
	#instVars : [
		'window',
		'renderer',
		'texture'
	],
	#pools : [
		'SDL2Constants'
	],
	#category : #'BlocHost-OSWindow-SDL2-Renderer'
}

{ #category : #initialization }
BlOSWindowSDL2BufferSurfaceRenderer >> initializeForSurface: aSurface [
	| textureExtent sdlSurface |

	textureExtent := aSurface physicalSize asPoint.
	
	sdlSurface := SDL2
		createRGBSurfaceForCairoWidth: textureExtent x
		height: textureExtent y.

	renderer := window handle renderer renderer.

	texture := renderer
		createTextureFormat: SDL_PIXELFORMAT_XRGB8888
		access: SDL_TEXTUREACCESS_STREAMING
		width: textureExtent x
		height: textureExtent y.

	aSurface
		buffer: sdlSurface pixels;
		stride: sdlSurface pitch;
		extent: textureExtent
]

{ #category : #rendering }
BlOSWindowSDL2BufferSurfaceRenderer >> renderSurface: aSurface damaged: aCollectionOfRectangles [
	"Render a given surface on a host space"

	texture
		updateTextureRect: nil
		pixels: aSurface buffer
		pitch: aSurface stride.

	renderer
		clear;
		copy: texture;
		present
]

{ #category : #accessing }
BlOSWindowSDL2BufferSurfaceRenderer >> window [
	^ window
]

{ #category : #accessing }
BlOSWindowSDL2BufferSurfaceRenderer >> window: anObject [
	window := anObject
]
