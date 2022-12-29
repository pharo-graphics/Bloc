"
I represent an OpenGL surface to be used by host renderer and host space.

When used, rendering happens using OpenGL context and than can be displayed in a native window

"
Class {
	#name : #BlHostRendererOpenGLSurface,
	#superclass : #BlHostRendererSurface,
	#instVars : [
		'context',
		'extent',
		'stencilBits',
		'sampleCount',
		'framebufferId',
		'framebufferFormat'
	],
	#category : #'Bloc-Universe - Renderer - NU'
}

{ #category : #testing }
BlHostRendererOpenGLSurface class >> isSupportedBy: anObject [
	"Return whether a given object supports OpenGL surface."

	^ anObject supportsOpenGLSurface
]

{ #category : #accessing }
BlHostRendererOpenGLSurface class >> priority [
	^ 10
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

{ #category : #accessing }
BlHostRendererOpenGLSurface >> framebufferFormat [
	^ framebufferFormat
]

{ #category : #accessing }
BlHostRendererOpenGLSurface >> framebufferFormat: anObject [
	framebufferFormat := anObject
]

{ #category : #accessing }
BlHostRendererOpenGLSurface >> framebufferId [
	^ framebufferId
]

{ #category : #accessing }
BlHostRendererOpenGLSurface >> framebufferId: anObject [
	framebufferId := anObject
]

{ #category : #accessing }
BlHostRendererOpenGLSurface >> sampleCount [
	^ sampleCount
]

{ #category : #accessing }
BlHostRendererOpenGLSurface >> sampleCount: anObject [
	sampleCount := anObject
]

{ #category : #accessing }
BlHostRendererOpenGLSurface >> stencilBits [
	^ stencilBits
]

{ #category : #accessing }
BlHostRendererOpenGLSurface >> stencilBits: anObject [
	stencilBits := anObject
]
