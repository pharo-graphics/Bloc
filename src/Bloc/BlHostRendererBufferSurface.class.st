"
I represent a pixel buffer surface to be used by host renderer and host space.

When used, rendering happens in a pixel buffer and than can be displayed in a native window
"
Class {
	#name : #BlHostRendererBufferSurface,
	#superclass : #BlHostRendererSurface,
	#instVars : [
		'stride',
		'buffer',
		'extent',
		'strongReference'
	],
	#category : #'Bloc-Universe - Renderer'
}

{ #category : #accessing }
BlHostRendererBufferSurface class >> priority [
	^ 20
]

{ #category : #testing }
BlHostRendererBufferSurface class >> supportedBy: anObject [
	"Return true if a given object supports buffer surface, false otherwise"
	<return: #Boolean>

	^ anObject supportsBufferSurface
]

{ #category : #accessing }
BlHostRendererBufferSurface >> buffer [
	^ buffer
]

{ #category : #accessing }
BlHostRendererBufferSurface >> buffer: aPixelBuffer [
	buffer := aPixelBuffer
]

{ #category : #initialization }
BlHostRendererBufferSurface >> createSpaceRendererOn: anObject [
	<return: #BlHostSpaceRenderer>

	^ anObject createBufferSpaceRenderer
]

{ #category : #initialization }
BlHostRendererBufferSurface >> createSurfaceRendererOn: anObject [
	<return: #BlHostSurfaceRenderer>

	^ anObject createBufferSurfaceRenderer
]

{ #category : #geometry }
BlHostRendererBufferSurface >> extent [
	"Return actual extent of the underlying surface.
	Note: it may be different from canvas or window extents"
	<return: #Point>
	
	^ extent
]

{ #category : #geometry }
BlHostRendererBufferSurface >> extent: aPoint [
	extent := aPoint
]

{ #category : #accessing }
BlHostRendererBufferSurface >> stride [
	^ stride
]

{ #category : #accessing }
BlHostRendererBufferSurface >> stride: aNumber [
	stride := aNumber
]

{ #category : #accessing }
BlHostRendererBufferSurface >> strongReference: anObject [

	strongReference := anObject
]
