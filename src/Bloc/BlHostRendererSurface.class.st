"
I am a mediator between host space and host renderer
"
Class {
	#name : #BlHostRendererSurface,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'hostSpace',
		'hostRenderer'
	],
	#category : #'Bloc-Universe'
}

{ #category : #accessing }
BlHostRendererSurface class >> allSurfaces [
	"Return a collection of all possible surfaces"
	<return: #Collection of: #'BlHostRendererSurface class'>

	^ self allSubclasses
]

{ #category : #testing }
BlHostRendererSurface class >> supportedBy: anObject [
	"Return true if a given object supports this surface, false otherwise"
	<return: #Boolean>
	
	^ self subclassResponsibility
]

{ #category : #geometry }
BlHostRendererSurface >> canvasExtent [
	"Return current canvas extent in pixels as a Point.
	Note, that canvas extent is different from windowExtent
	and is normally x2 bigger on retina screens"
	<return: #Point>

	^ self hostSpace canvasExtent
]

{ #category : #geometry }
BlHostRendererSurface >> extent [
	"Return an actual extent of the underlying surface.
	Note: between frames #extent may be different from canvas or window extents because
	those two methods return immediate/current window extent by asking host window directly"
	<return: #Point>

	^ self subclassResponsibility
]

{ #category : #accessing }
BlHostRendererSurface >> hostRenderer [
	^ hostRenderer
]

{ #category : #accessing }
BlHostRendererSurface >> hostRenderer: anObject [
	hostRenderer := anObject
]

{ #category : #accessing }
BlHostRendererSurface >> hostSpace [
	^ hostSpace
]

{ #category : #accessing }
BlHostRendererSurface >> hostSpace: anObject [
	hostSpace := anObject
]

{ #category : #initialization }
BlHostRendererSurface >> initializeOn: anObject [
	"Initialize a given object to work with this surface.
	must be implemented by subclasses"
	
	self subclassResponsibility
]

{ #category : #initialization }
BlHostRendererSurface >> initializeResourcesOn: aHostRenderer [
	"Initialize me and host renderer depending on surface type.
	must be implemented by subclasses"
	
	self subclassResponsibility
]

{ #category : #rendering }
BlHostRendererSurface >> prepareToRender: aSpace [
	"Dispatch preparation to render through host space based on surface type"
	
	self subclassResponsibility
]

{ #category : #presenting }
BlHostRendererSurface >> presentAreas: aCollectionOfRectangles [
	self subclassResponsibility
]

{ #category : #rendering }
BlHostRendererSurface >> renderFor: aSpace [
	"Dispatch render process through host space based on surface type"
	
	self subclassResponsibility
]

{ #category : #geometry }
BlHostRendererSurface >> scaleFactor [
	"Return a scaling factor from space to window coordinates.
	On high dpi (retina) displays scaling factor is > 1"
	<return: #Point>
	
	^ self hostSpace scaleFactor
]

{ #category : #geometry }
BlHostRendererSurface >> windowExtent [
	"Return current window extent in pixels as a Point.
	Note, that window extent is different from canvasExtent
	and is normally x2 smaller on retina screens"
	<return: #Point>

	^ self hostSpace windowExtent
]
