Class {
	#name : #BlGlutinRendererBuffer,
	#superclass : #BlGlutinRenderer,
	#instVars : [
		'renderer'
	],
	#category : #'BlocHost-Glutin'
}

{ #category : #'host space - drawing' }
BlGlutinRendererBuffer >> initializeForBuffer: aBlHostRendererBufferSurface [
	| aForm thePixels anExtent |
	
	self
		assert: [ self window isNotNil ]
		description: [ 'Window must be set!' ].
		
	renderer
		ifNil: [ renderer := GlutinOpenGLBufferRenderer new window: self window ].

	anExtent := aBlHostRendererBufferSurface canvasExtent.
	
	aForm := Form extent: anExtent depth: 32.

	thePixels := FFIExternalArray externalNewType: FFIUInt32 size: aForm stride * aForm height.
	thePixels autoRelease.

	aBlHostRendererBufferSurface
		buffer: thePixels getHandle;
		stride: aForm stride;
		extent: anExtent
]

{ #category : #'host space - drawing' }
BlGlutinRendererBuffer >> presentBufferSurface: aBlHostRendererBufferSurface areas: aCollectionOfAreas [
	| aBuffer |
	
	aBuffer := GlutinOpenGLBuffer new
		extent: aBlHostRendererBufferSurface extent;
		stride: aBlHostRendererBufferSurface stride;
		pixels: aBlHostRendererBufferSurface buffer.
	
	renderer presentBuffer: aBuffer areas: aCollectionOfAreas
]
