Class {
	#name : #BlGlutinRendererBuffer,
	#superclass : #BlGlutinSurfaceRenderer,
	#instVars : [
		'renderer'
	],
	#category : #'BlocHost-Glutin-Renderer'
}

{ #category : #'host space - drawing' }
BlGlutinRendererBuffer >> initializeForSurface: aSurface [
	| aForm thePixels anExtent |
	
	self
		assert: [ self window isNotNil ]
		description: [ 'Window must be set!' ].

	renderer
		ifNil: [ renderer := GlutinGLBufferRenderer new window: self window ].

	anExtent := aSurface physicalSize asPoint.
	
	aForm := Form extent: anExtent depth: 32.

	thePixels := FFIExternalArray externalNewType: FFIUInt32 size: aForm stride * aForm height.
	thePixels autoRelease.

	aSurface
		buffer: thePixels getHandle;
		stride: aForm stride;
		extent: anExtent
]

{ #category : #'host space - drawing' }
BlGlutinRendererBuffer >> presentBufferSurface: aBlHostRendererBufferSurface areas: aCollectionOfAreas [
	| aBuffer |
	
	aBuffer := GlutinGLBuffer new
		extent: aBlHostRendererBufferSurface extent;
		stride: aBlHostRendererBufferSurface stride;
		pixels: aBlHostRendererBufferSurface buffer.
	
	renderer presentBuffer: aBuffer areas: aCollectionOfAreas
]
