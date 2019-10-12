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
	#category : #'Bloc-Universe - Renderer'
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

{ #category : #initialization }
BlHostRendererFormSurface >> createSpaceRendererOn: anObject [
	<return: #BlHostSpaceRenderer>

	^ anObject createFormSpaceRenderer
]

{ #category : #initialization }
BlHostRendererFormSurface >> createSurfaceRendererOn: anObject [
	<return: #BlHostSurfaceRenderer>
	
	^ anObject createFormSurfaceRenderer
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
BlHostRendererFormSurface >> initializeResourcesOn: aHostRenderer [
	externalForm := BlExternalForm
		extent: self physicalSize width @ self physicalSize height
		depth: 32.
	externalForm autoRelease.
	externalForm allocateSpace.
	externalForm fillColor: Color transparent.
	self initializeOn: aHostRenderer
]

{ #category : #accessing }
BlHostRendererFormSurface >> pointer [
	^ externalForm pointer
]

{ #category : #accessing }
BlHostRendererFormSurface >> stride [
	^ externalForm stride
]
