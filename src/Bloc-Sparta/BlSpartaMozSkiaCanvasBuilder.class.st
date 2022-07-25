"
I am a copy of class BlSpartaMozCanvasBuilder. This comment is copied from there, and might not be entirely accurate

I build sparta canvas using Moz2D backend
"
Class {
	#name : #BlSpartaMozSkiaCanvasBuilder,
	#superclass : #BlSpartaCanvasBuilder,
	#category : #'Bloc-Sparta-canvas'
}

{ #category : #'api - instance creation' }
BlSpartaMozSkiaCanvasBuilder class >> extent: aPoint [
	"Create a default canvas of a given size that should be used for output on screen"
	<return: #SpartaCanvas>
	
	^ (self environment at: #MozCanvas) extent: aPoint
]

{ #category : #accessing }
BlSpartaMozSkiaCanvasBuilder class >> isSupported [
	<return: #Boolean>
	
	^ (self environment includesKey: #MozSkiaCanvas) and: [ (self environment at: #MozSkiaCanvas) isSupported ]
]

{ #category : #accessing }
BlSpartaMozSkiaCanvasBuilder class >> label [
	<return: #String>
	^ 'Moz2D - Skia'
]

{ #category : #'instance creation' }
BlSpartaMozSkiaCanvasBuilder class >> offscreen [
	<return: #SpartaCanvas>

	^ (self environment at: #MozSkiaOffscreenCanvas) uniqueInstance
]

{ #category : #accessing }
BlSpartaMozSkiaCanvasBuilder class >> priority [
	^ 10
]

{ #category : #testing }
BlSpartaMozSkiaCanvasBuilder class >> supportsBufferSurface [
	"Return true if this canvas builder can work with a buffer surface, false otherwise"
	<return: #Boolean>
	
	^ false
]

{ #category : #testing }
BlSpartaMozSkiaCanvasBuilder class >> supportsFormSurface [
	"Return true if this canvas builder can work with form surface, false otherwise"
	<return: #Boolean>
	
	^ false
]

{ #category : #testing }
BlSpartaMozSkiaCanvasBuilder class >> supportsOpenGLSurface [
	"Return true if this renderer can work with OpenGL surface, false otherwise"
	<return: #Boolean>
	
	^ true
]

{ #category : #'instance creation' }
BlSpartaMozSkiaCanvasBuilder >> forBufferOn: aRendererSurface [
	<return: #SpartaCanvas>

	^ (self class environment at: #MozSkiaCanvas)
		createForData: aRendererSurface buffer
		type: (self class environment at: #MozBackendType) SKIA
		extent: aRendererSurface extent
		stride: aRendererSurface stride
		format: (self class environment at: #MozSurfaceFormat) B8G8R8A8
]

{ #category : #'instance creation' }
BlSpartaMozSkiaCanvasBuilder >> forFormOn: aRendererSurface [
	<return: #SpartaCanvas>

	^ (self class environment at: #MozSkiaCanvas)
		createForData: aRendererSurface pointer
		type: (self class environment at: #MozBackendType) SKIA
		extent: aRendererSurface extent
		stride: aRendererSurface stride
		format: (self class environment at: #MozSurfaceFormat) B8G8R8A8
]

{ #category : #'instance creation' }
BlSpartaMozSkiaCanvasBuilder >> forOpenGLOn: aRendererSurface [
	<return: #SpartaCanvas>
	^ (self class environment at: #MozSkiaCanvas)
		extent: aRendererSurface logicalSize asPoint
		renderExtent: aRendererSurface physicalSize asPoint
]
