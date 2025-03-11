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

	| textureExtent textureStride surfaceBuffer |
	sdlRenderer := window backendWindow renderer sdlRenderer.

	textureExtent := aBlHostRendererBufferSurface physicalSize asPoint.
	textureStride := textureExtent x * 4.
	surfaceBuffer := ByteArray new: textureStride * textureExtent y.

	texture := sdlRenderer
		createTextureFormat: SDL_PIXELFORMAT_XRGB8888
		access: SDL_TEXTUREACCESS_STREAMING
		width: textureExtent x
		height: textureExtent y.

	aBlHostRendererBufferSurface
		buffer: surfaceBuffer;
		stride: textureStride;
		extent: textureExtent
]

{ #category : #rendering }
BlOSWindowSDL2BufferSurfaceRenderer >> lockSurfaceFor: damagedRectangles scaleFactor: aNumber during: aBlock [

	| damagedRectangle aCairoSurface pixelsAddress |
	"For now we only support a single rectangle"
	damagedRectangle := Rectangle merging: damagedRectangles.

	pixelsAddress := ExternalAddress new.
 	ExternalAddress
		allocate: Smalltalk wordSize
		bytesDuring: [ :pitchAddress |
			| physicalDamagedRectangle |
			physicalDamagedRectangle := damagedRectangle scaleBy: aNumber.
			texture
				lockRect: physicalDamagedRectangle asSDLRect
				pixels: pixelsAddress 
				pitch: pitchAddress.
			aCairoSurface := AeCairoImageSurface
				unownedNewForData: pixelsAddress
			   format: AeCairoSurfaceFormat argb32
			   width: physicalDamagedRectangle width
			   height: physicalDamagedRectangle height
			   stride: (pitchAddress signedLongAt: 1).
			aCairoSurface
				deviceOffset: physicalDamagedRectangle origin negated;
				deviceScaleX: aNumber y: aNumber.
			
			aBlock value: aCairoSurface.
				
			aCairoSurface flush.
			aCairoSurface externallyFree.
			texture unlock ].

	"No need to clear the renderer as texture has no blending and covers all pixels"
	sdlRenderer
		copy: texture;
		present
]

{ #category : #rendering }
BlOSWindowSDL2BufferSurfaceRenderer >> renderSurface: aBlHostRendererBufferSurface damaged: aCollectionOfRectangles [
	"Render a given surface on a host space. Collection of damaged rectangles is not taken into account."

	aCollectionOfRectangles size = 1
		ifTrue: [
			| damagedRectangle damagedCairoSurface fullCairoSurface pixelsAddress pitchAddress |
			pitchAddress := ExternalAddress newPointer.
			pixelsAddress := ExternalAddress newPointer.
			damagedRectangle := aCollectionOfRectangles anyOne.

			texture
				lockRect: damagedRectangle asSDLRect
				pixels: pixelsAddress
				pitch: pitchAddress.
			fullCairoSurface := AeCairoImageSurface
				newForData: aBlHostRendererBufferSurface buffer
				extent: aBlHostRendererBufferSurface physicalSize asPoint
				stride: aBlHostRendererBufferSurface stride
				format: AeCairoSurfaceFormat argb32.
			damagedCairoSurface := AeCairoImageSurface
				newForData: pixelsAddress
				extent: damagedRectangle extent
				stride: (pitchAddress signedLongAt: 1)
				format: AeCairoSurfaceFormat argb32.
			damagedCairoSurface newContext
				clearTransparent;
				sourceSurface: fullCairoSurface
					x: damagedRectangle left negated
					y: damagedRectangle top negated;
				paint.
			damagedCairoSurface flush.
			texture unlock ]
		ifFalse: [ 
			texture
				updateTexturePixels: aBlHostRendererBufferSurface buffer
				pitch: aBlHostRendererBufferSurface stride ].

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
