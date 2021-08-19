Class {
	#name : #BlOSWindowSDL2BufferSurfaceRenderer,
	#superclass : #BlHostSurfaceRenderer,
	#instVars : [
		'window',
		'texture',
		'sdlRenderer'
	],
	#pools : [
		'SDL2Constants'
	],
	#category : #'BlocHost-OSWindow-SDL2-Renderer'
}

{ #category : #initialization }
BlOSWindowSDL2BufferSurfaceRenderer >> initializeForSurface: aBlHostRendererBufferSurface [

	| textureExtent sdlSurface |
	textureExtent := aBlHostRendererBufferSurface physicalSize asPoint.
	
	sdlSurface := SDL2
		createRGBSurfaceForCairoWidth: textureExtent x
		height: textureExtent y.

	sdlRenderer := window backendWindow renderer sdlRenderer.

	texture := sdlRenderer
		createTextureFormat: SDL_PIXELFORMAT_XRGB8888
		access: SDL_TEXTUREACCESS_STREAMING
		width: textureExtent x
		height: textureExtent y.

	aBlHostRendererBufferSurface
		buffer: sdlSurface pixels;
		stride: sdlSurface pitch;
		extent: textureExtent
]

{ #category : #rendering }
BlOSWindowSDL2BufferSurfaceRenderer >> renderSurface: aBlHostRendererBufferSurface damaged: aCollectionOfRectangles [
	"Render a given surface on a host space. Collection of damaged rectangles is not taken into account."

	texture
		updateTextureRect: nil
		pixels: aBlHostRendererBufferSurface buffer
		pitch: aBlHostRendererBufferSurface stride.

	sdlRenderer
		clear;
		copy: texture;
		present
]

{ #category : #accessing }
BlOSWindowSDL2BufferSurfaceRenderer >> window [
	"Answer my OSWindow."

	^ window
]

{ #category : #accessing }
BlOSWindowSDL2BufferSurfaceRenderer >> window: aOSWindow [

	window := aOSWindow
]
