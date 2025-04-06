Class {
	#name : #BlHeadlessBufferSurfaceRenderer,
	#superclass : #BlHostSurfaceRenderer,
	#instVars : [
		'thePixels'
	],
	#category : #'Bloc-Universe - Host Headless'
}

{ #category : #initialization }
BlHeadlessBufferSurfaceRenderer >> initializeForSurface: aSurface [

	| aForm anExtent |
	anExtent := aSurface physicalSize asPoint.
	
	aForm := Form extent: anExtent depth: 32.

	thePixels := FFIExternalArray
		newType: FFIUInt32
		size: aForm stride * aForm height.

	aSurface
		buffer: thePixels getHandle;
		stride: aForm stride;
		extent: anExtent
]
