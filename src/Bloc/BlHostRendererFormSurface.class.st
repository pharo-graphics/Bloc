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

{ #category : #testing }
BlHostRendererFormSurface class >> isSupportedBy: anObject [
	"Return whether a given object supports Form surface."

	^ anObject supportsFormSurface
]

{ #category : #accessing }
BlHostRendererFormSurface class >> priority [

	^ 30
]

{ #category : #initialization }
BlHostRendererFormSurface >> createSpaceRendererOn: anObject [

	^ anObject createFormSpaceRenderer
]

{ #category : #initialization }
BlHostRendererFormSurface >> createSurfaceRendererOn: anObject [
	
	^ anObject createFormSurfaceRenderer
]

{ #category : #geometry }
BlHostRendererFormSurface >> extent [
	
	^ externalForm extent
]

{ #category : #accessing }
BlHostRendererFormSurface >> form [

	^ externalForm
]

{ #category : #accessing }
BlHostRendererFormSurface >> form: aForm [

	externalForm := aForm
]

{ #category : #accessing }
BlHostRendererFormSurface >> pointer [

	^ externalForm pointer
]

{ #category : #accessing }
BlHostRendererFormSurface >> stride [

	^ externalForm stride
]
