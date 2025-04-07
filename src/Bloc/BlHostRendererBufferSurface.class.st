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
		'extent'
	],
	#category : #'Bloc-Universe - Renderer'
}

{ #category : #testing }
BlHostRendererBufferSurface class >> isSupportedBy: anObject [
	"Return whether a given object supports buffer surface."

	^ anObject supportsBufferSurface
]

{ #category : #accessing }
BlHostRendererBufferSurface class >> priority [

	^ 20
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

	^ anObject createBufferSpaceRenderer
]

{ #category : #initialization }
BlHostRendererBufferSurface >> createSurfaceRendererOn: anObject [

	^ anObject createBufferSurfaceRenderer
]

{ #category : #geometry }
BlHostRendererBufferSurface >> extent [
	
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
