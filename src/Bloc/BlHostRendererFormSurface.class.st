"
I represent a form surface to be used by host renderer and host space.

When used, rendering happens in a Form and than can be displayed in a morphic window
"
Class {
	#name : #BlHostRendererFormSurface,
	#superclass : #BlHostRendererSurface,
	#instVars : [
		'externalForm'
	],
	#category : #'Bloc-Universe - Host'
}

{ #category : #accessing }
BlHostRendererFormSurface class >> priority [
	^ 30
]

{ #category : #testing }
BlHostRendererFormSurface class >> supportedBy: anObject [
	"Return true if a given object supports form surface, false otherwise"
	<return: #Boolean>

	^ anObject supportsFormSurface
]

{ #category : #geometry }
BlHostRendererFormSurface >> extent [
	"Return actual extent of the underlying surface.
	Note: it may be different from canvas or window extents"
	<return: #Point>
	
	^ externalForm extent
]

{ #category : #accessing }
BlHostRendererFormSurface >> form [
	^ externalForm
]

{ #category : #initialization }
BlHostRendererFormSurface >> initializeOn: anObject [
	anObject initializeForForm: self
]

{ #category : #initialization }
BlHostRendererFormSurface >> initializeResourcesOn: aHostRenderer [
	externalForm := BlExternalForm extent: self canvasExtent depth: 32.
	externalForm autoRelease.
	externalForm allocateSpace.
	externalForm fillColor: Color transparent.

	self initializeOn: aHostRenderer
]

{ #category : #accessing }
BlHostRendererFormSurface >> pointer [
	^ externalForm pointer
]

{ #category : #rendering }
BlHostRendererFormSurface >> prepareToRender: aSpace [
	"Dispatch preparation to render through host space based on surface type"
	
	self hostSpace prepareToRender: aSpace onFormSurface: self
]

{ #category : #presenting }
BlHostRendererFormSurface >> presentAreas: aCollectionOfRectangles [
	hostSpace presentFormSurface: self areas: aCollectionOfRectangles
]

{ #category : #rendering }
BlHostRendererFormSurface >> renderFor: aSpace [
	"Dispatch render process through host space based on surface type"
	
	self hostSpace render: aSpace onFormSurface: self
]

{ #category : #accessing }
BlHostRendererFormSurface >> stride [
	^ externalForm stride
]
