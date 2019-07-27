"
I build sparta canvas using Moz2D backend
"
Class {
	#name : #BlSpartaMozCanvasBuilder,
	#superclass : #BlSpartaCanvasBuilder,
	#category : 'Bloc-Sparta'
}

{ #category : #'api - instance creation' }
BlSpartaMozCanvasBuilder class >> extent: aPoint [
	<return: #SpartaCanvas>

	^ (self environment at: #MozCanvas) extent: aPoint
]

{ #category : #accessing }
BlSpartaMozCanvasBuilder class >> isSupported [
	<return: #Boolean>

	^ (self environment includesKey: #MozCanvas)
		and: [ (self environment at: #MozLibrary) uniqueInstance hasModule ]
]

{ #category : #accessing }
BlSpartaMozCanvasBuilder class >> label [
	<return: #String>
	^ 'Moz2D'
]

{ #category : #'instance creation' }
BlSpartaMozCanvasBuilder class >> offscreen [
	<return: #SpartaCanvas>

	^ (self environment at: #MozOffscreenCanvas) uniqueInstance
]

{ #category : #'api - instance creation' }
BlSpartaMozCanvasBuilder class >> pdf: aFileName extent: aPoint [
	^ MozCanvas pdf: aFileName extent: aPoint
]

{ #category : #accessing }
BlSpartaMozCanvasBuilder class >> priority [
	^ 20
]

{ #category : #testing }
BlSpartaMozCanvasBuilder class >> supportsBufferSurface [
	"Return true if this canvas builder can work with a buffer surface, false otherwise"
	<return: #Boolean>
	
	^ true
]

{ #category : #testing }
BlSpartaMozCanvasBuilder class >> supportsFormSurface [
	"Return true if this canvas builder can work with form surface, false otherwise"
	<return: #Boolean>
	
	^ true
]

{ #category : #testing }
BlSpartaMozCanvasBuilder class >> supportsOpenGLSurface [
	"Return true if this renderer can work with OpenGL surface, false otherwise"
	<return: #Boolean>
	
	^ false
]

{ #category : #'api - instance creation' }
BlSpartaMozCanvasBuilder class >> svg: aFileName extent: aPoint [
	^ MozCanvas svg: aFileName extent: aPoint
]

{ #category : #'instance creation' }
BlSpartaMozCanvasBuilder >> forBufferOn: aRendererSurface [
	<return: #SpartaCanvas>

	^ (self class environment at: #MozCanvas)
		createForData: aRendererSurface buffer
		type: (self class environment at: #MozBackendType) SKIA
		extent: aRendererSurface extent
		stride: aRendererSurface stride
		format: (self class environment at: #MozSurfaceFormat) B8G8R8A8
]

{ #category : #'instance creation' }
BlSpartaMozCanvasBuilder >> forFormOn: aRendererSurface [
	<return: #SpartaCanvas>

	^ (self class environment at: #MozCanvas)
		createForData: aRendererSurface pointer
		type: (self class environment at: #MozBackendType) SKIA
		extent: aRendererSurface extent
		stride: aRendererSurface stride
		format: (self class environment at: #MozSurfaceFormat) B8G8R8A8
]

{ #category : #'instance creation' }
BlSpartaMozCanvasBuilder >> forOpenGLOn: aRendererSurface [
	<return: #SpartaCanvas>
	
	^ self shouldNotImplement
]
