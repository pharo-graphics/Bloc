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
	#category : 'Bloc-Universe'
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

{ #category : #initialization }
BlHostRendererBufferSurface >> initializeOn: anObject [
	anObject initializeForBuffer: self
]

{ #category : #initialization }
BlHostRendererBufferSurface >> initializeResourcesOn: aHostRenderer [
	self initializeOn: aHostRenderer
]

{ #category : #rendering }
BlHostRendererBufferSurface >> prepareToRender: aSpace [
	"Dispatch preparation to render through host space based on surface type"
	
	self hostSpace prepareToRender: aSpace onBufferSurface: self
]

{ #category : #presenting }
BlHostRendererBufferSurface >> presentAreas: aCollectionOfRectangles [
	hostSpace presentBufferSurface: self areas: aCollectionOfRectangles
]

{ #category : #rendering }
BlHostRendererBufferSurface >> renderFor: aSpace [
	"Dispatch render process through host space based on surface type"
	
	self hostSpace render: aSpace onBufferSurface: self
]

{ #category : #accessing }
BlHostRendererBufferSurface >> stride [
	^ stride
]

{ #category : #accessing }
BlHostRendererBufferSurface >> stride: aNumber [
	stride := aNumber
]
