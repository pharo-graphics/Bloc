Class {
	#name : #BlHeadlessBufferSurfaceRenderer,
	#superclass : #BlHostSurfaceRenderer,
	#instVars : [
		'thePixels'
	],
	#category : 'Bloc-Universe - Host Headless'
}

{ #category : #initialization }
BlHeadlessBufferSurfaceRenderer >> initializeForSurface: aSurface [

	| aForm anExtent |
	anExtent := aSurface physicalSize asPoint.
	
	aForm := Form extent: anExtent depth: 32.

	thePixels := AeFFIUInt32Array newOf: aForm stride * aForm height.

	aSurface
		buffer: thePixels getHandle;
		stride: aForm stride;
		extent: anExtent
]

{ #category : #initialization }
BlHeadlessBufferSurfaceRenderer >> renderSurface: aSurface damaged: aCollectionOfRectangles [
]
