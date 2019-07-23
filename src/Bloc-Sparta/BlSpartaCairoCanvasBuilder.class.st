"
I build sparta canvas using Cairo backend
"
Class {
	#name : #BlSpartaCairoCanvasBuilder,
	#superclass : #BlSpartaCanvasBuilder,
	#category : 'Bloc-Sparta'
}

{ #category : #'api - instance creation' }
BlSpartaCairoCanvasBuilder class >> extent: aPoint [
	<return: #SpartaCanvas>
	
	^ (self environment at: #SpartaCairoCanvas) extent: aPoint
]

{ #category : #accessing }
BlSpartaCairoCanvasBuilder class >> isSupported [
	<return: #Boolean>
	^ self environment includesKey: #SpartaCairoCanvas
]

{ #category : #accessing }
BlSpartaCairoCanvasBuilder class >> label [
	<return: #String>
	^ 'Cairo'
]

{ #category : #'instance creation' }
BlSpartaCairoCanvasBuilder class >> offscreen [
	<return: #SpartaCanvas>

	^ (self environment at: #SpartaCairoOffscreenCanvas) uniqueInstance
]

{ #category : #'api - instance creation' }
BlSpartaCairoCanvasBuilder class >> pdf: aFileName extent: aPoint [
	^ SpartaCairoCanvas pdf: aFileName extent: aPoint
]

{ #category : #accessing }
BlSpartaCairoCanvasBuilder class >> priority [
	^ 30
]

{ #category : #testing }
BlSpartaCairoCanvasBuilder class >> supportsBufferSurface [
	"Return true if this canvas builder can work with a buffer surface, false otherwise"
	<return: #Boolean>
	
	^ true
]

{ #category : #testing }
BlSpartaCairoCanvasBuilder class >> supportsFormSurface [
	"Return true if this canvas builder can work with form surface, false otherwise"
	<return: #Boolean>
	
	^ true
]

{ #category : #testing }
BlSpartaCairoCanvasBuilder class >> supportsOpenGLSurface [
	"Return true if this renderer can work with OpenGL surface, false otherwise"
	<return: #Boolean>
	
	^ false
]

{ #category : #'api - instance creation' }
BlSpartaCairoCanvasBuilder class >> svg: aFileName extent: aPoint [
	^ SpartaCairoCanvas svg: aFileName extent: aPoint
]

{ #category : #'instance creation' }
BlSpartaCairoCanvasBuilder >> forBufferOn: aRendererSurface [
	<return: #SpartaCanvas>

	^ (self class environment at: #SpartaCairoCanvas)
		createForData: aRendererSurface buffer
		extent: aRendererSurface extent
		stride: aRendererSurface stride
		format: (self class environment at: #SpartaCairoSurfaceFormat) CAIRO_FORMAT_ARGB32
]

{ #category : #'instance creation' }
BlSpartaCairoCanvasBuilder >> forFormOn: aRendererSurface [
	<return: #SpartaCanvas>

	^ (self class environment at: #SpartaCairoCanvas)
		createForData: aRendererSurface pointer
		extent: aRendererSurface extent
		stride: aRendererSurface stride
		format: (self class environment at: #SpartaCairoSurfaceFormat) CAIRO_FORMAT_ARGB32
]

{ #category : #'instance creation' }
BlSpartaCairoCanvasBuilder >> forOpenGLOn: aRendererSurface [
	<return: #SpartaCanvas>
	
	^ self shouldNotImplement
]
