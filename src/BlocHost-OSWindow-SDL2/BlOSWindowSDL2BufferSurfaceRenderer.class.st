Class {
	#name : #BlOSWindowSDL2BufferSurfaceRenderer,
	#superclass : #BlHostSurfaceRenderer,
	#instVars : [
		'window',
		'texture',
		'sdlRenderer',
		'texturePhysicalRectangle'
	],
	#pools : [
		'SDL2Constants'
	],
	#category : #'BlocHost-OSWindow-SDL2-Renderer'
}

{ #category : #initialization }
BlOSWindowSDL2BufferSurfaceRenderer >> initializeForSurface: aBlHostRendererBufferSurface [

	| textureStride surfaceBuffer texturePhysicalExtent |
	sdlRenderer := window backendWindow renderer sdlRenderer.

	texturePhysicalExtent := aBlHostRendererBufferSurface physicalSize asPoint.
	texturePhysicalRectangle := 0@0 extent: texturePhysicalExtent.
	textureStride := texturePhysicalExtent x * 4.
	surfaceBuffer := ByteArray new: textureStride * texturePhysicalExtent y.

	texture := sdlRenderer
		createTextureFormat: SDL_PIXELFORMAT_XRGB8888
		access: SDL_TEXTUREACCESS_STREAMING
		width: texturePhysicalExtent x
		height: texturePhysicalExtent y.

	aBlHostRendererBufferSurface
		buffer: surfaceBuffer;
		stride: textureStride;
		extent: texturePhysicalExtent
]

{ #category : #rendering }
BlOSWindowSDL2BufferSurfaceRenderer >> lockSurfaceFor: damagedRectangles scaleFactor: aNumber during: aBlock [

	| damagedRectangle physicalDamagedRectangle |
	"For now we only support a single rectangle"
	damagedRectangle := Rectangle merging: damagedRectangles.
	
	self class logDamagedRectangle: damagedRectangle.
	
	physicalDamagedRectangle := damagedRectangle scaleBy: aNumber.

	"The only changed rectangle is outside of the window"
	physicalDamagedRectangle := physicalDamagedRectangle intersect: texturePhysicalRectangle.
	physicalDamagedRectangle isZero ifTrue: [ ^ self ].


 	ExternalAddress
		allocate: Smalltalk wordSize
		bytesDuring: [ :pitchAddress |
			| aCairoSurface pixelsAddress aeCanvas |
			
			pixelsAddress := ExternalAddress new.
			(texture
				lockRect: physicalDamagedRectangle asSDLRect
				pixels: pixelsAddress 
				pitch: pitchAddress) = 0 ifFalse: [ SDL2 checkForError ].

			aCairoSurface := AeCairoImageSurface
				unownedNewForData: pixelsAddress
			   format: AeCairoSurfaceFormat argb32
			   width: physicalDamagedRectangle width
			   height: physicalDamagedRectangle height
			   stride: (pitchAddress signedLongAt: 1).
			aCairoSurface
				deviceOffset: physicalDamagedRectangle origin negated;
				deviceScaleX: aNumber y: aNumber.
			aeCanvas := AeCanvas newFor: aCairoSurface.
			aeCanvas clippingRectangle: damagedRectangle.

			aBlock value: aeCanvas.

			"DEBUG: draw dashed border on the area"
			self class drawDamagedRectangle: damagedRectangle on: aeCanvas.

			aCairoSurface flush.
			aeCanvas privateAeCairoContext externallyFree.
			aCairoSurface externallyFree.
			texture unlock ].

	"No need to clear the renderer as texture is opaque and covers all pixels"
	sdlRenderer
		copy: texture;
		present
]

{ #category : #rendering }
BlOSWindowSDL2BufferSurfaceRenderer >> renderSurface: aBlHostRendererBufferSurface damaged: aCollectionOfRectangles [
	"Render a given surface on a host space. Collection of damaged rectangles is not taken into account."

	self error: 'to be deleted'
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
