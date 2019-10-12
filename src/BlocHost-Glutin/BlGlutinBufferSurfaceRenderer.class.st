Class {
	#name : #BlGlutinBufferSurfaceRenderer,
	#superclass : #BlGlutinSurfaceRenderer,
	#instVars : [
		'renderer'
	],
	#category : #'BlocHost-Glutin-Renderer'
}

{ #category : #'host space - drawing' }
BlGlutinBufferSurfaceRenderer >> initializeForSurface: aSurface [
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
BlGlutinBufferSurfaceRenderer >> renderSurface: aSurface damaged: aCollectionOfRectangles [
	| aBuffer |
	
	aBuffer := GlutinGLBuffer new
		extent: aSurface extent;
		stride: aSurface stride;
		pixels: aSurface buffer.
	
	renderer presentBuffer: aBuffer areas: aCollectionOfRectangles
]
