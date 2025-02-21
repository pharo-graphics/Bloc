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

	| textureExtent stride buffer |
	textureExtent := aBlHostRendererBufferSurface physicalSize asPoint.
	
	sdlRenderer := window backendWindow renderer sdlRenderer.

	texture := sdlRenderer
		createTextureFormat: SDL_PIXELFORMAT_XRGB8888
		access: SDL_TEXTUREACCESS_STATIC
		width: textureExtent x
		height: textureExtent y.

	stride := textureExtent x * 4.
	buffer := ByteArray new: stride * textureExtent y.

	aBlHostRendererBufferSurface
		buffer: buffer;
		stride: stride;
		extent: textureExtent
]

{ #category : #rendering }
BlOSWindowSDL2BufferSurfaceRenderer >> renderSurface: aBlHostRendererBufferSurface damaged: aCollectionOfRectangles [
	"Render a given surface on a host space. Collection of damaged rectangles is not taken into account."

	texture
		updateTextureRect: nil
		pixels: aBlHostRendererBufferSurface buffer
		pitch: aBlHostRendererBufferSurface stride.

	"No need to clear the renderer as texture has no blending and covers all pixels"
	sdlRenderer
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
