"
I represent an OpenGL surface to be used by host renderer and host space.

When used, rendering happens using OpenGL context and than can be displayed in a native window
"
Class {
	#name : #BlHostRendererOpenGLSurface,
	#superclass : #BlHostRendererSurface,
	#instVars : [
		'context',
		'extent'
	],
	#category : #'Bloc-Universe - Renderer'
}

{ #category : #accessing }
BlHostRendererOpenGLSurface class >> priority [
	^ 10
]

{ #category : #testing }
BlHostRendererOpenGLSurface class >> supportedBy: anObject [
	"Return true if a given object supports OpenGL surface, false otherwise"
	<return: #Boolean>

	^ anObject supportsOpenGLSurface
]

{ #category : #accessing }
BlHostRendererOpenGLSurface >> context [
	^ context
]

{ #category : #accessing }
BlHostRendererOpenGLSurface >> context: anObject [
	context := anObject
]

{ #category : #initialization }
BlHostRendererOpenGLSurface >> createSpaceRendererOn: anObject [
	<return: #BlHostSpaceRenderer>

	^ anObject createOpenGLSpaceRenderer
]

{ #category : #initialization }
BlHostRendererOpenGLSurface >> createSurfaceRendererOn: anObject [
	<return: #BlHostSurfaceRenderer>

	^ anObject createOpenGLSurfaceRenderer
]

{ #category : #accessing }
BlHostRendererOpenGLSurface >> extent [
	^ extent
]

{ #category : #accessing }
BlHostRendererOpenGLSurface >> extent: anObject [
	extent := anObject
]

{ #category : #initialization }
BlHostRendererOpenGLSurface >> initializeResourcesOn: aHostRenderer [
	"Initialize me and host renderer depending on surface type.
	must be implemented by subclasses"
	
	self initializeOn: aHostRenderer
]
