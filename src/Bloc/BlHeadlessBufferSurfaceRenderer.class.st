Class {
	#name : 'BlHeadlessBufferSurfaceRenderer',
	#superclass : 'BlHostSurfaceRenderer',
	#category : 'Bloc-Universe - Host Headless'
}

{ #category : 'initialization' }
BlHeadlessBufferSurfaceRenderer >> initializeForSurface: aSurface [
	| aForm thePixels anExtent |
	
	anExtent := aSurface physicalSize asPoint.
	
	aForm := Form extent: anExtent depth: 32.

	thePixels := FFIExternalArray externalNewType: FFIUInt32 size: aForm stride * aForm height.
	thePixels autoRelease.

	aSurface
		buffer: thePixels getHandle;
		stride: aForm stride;
		extent: anExtent
]

{ #category : 'initialization' }
BlHeadlessBufferSurfaceRenderer >> renderSurface: aSurface damaged: aCollectionOfRectangles [
]
