"
I build sparta canvas using Skia backend
"
Class {
	#name : #BlSpartaSkiaCanvasBuilder,
	#superclass : #BlSpartaCanvasBuilder,
	#category : #'Bloc-Sparta'
}

{ #category : #'api - instance creation' }
BlSpartaSkiaCanvasBuilder class >> extent: aPoint [
	"Create a default canvas of a given size that should be used for output on screen"
	<return: #SpartaCanvas>
	
	^ (self environment at: #MozCanvas) extent: aPoint
]

{ #category : #accessing }
BlSpartaSkiaCanvasBuilder class >> isSupported [
	<return: #Boolean>
	
	^ (self environment includesKey: #SkiaCanvas) and: [ (self environment at: #SkiaCanvas) isSupported ]
]

{ #category : #accessing }
BlSpartaSkiaCanvasBuilder class >> label [
	<return: #String>
	^ 'Skia'
]

{ #category : #'instance creation' }
BlSpartaSkiaCanvasBuilder class >> offscreen [
	<return: #SpartaCanvas>

	^ (self environment at: #SkiaOffscreenCanvas) uniqueInstance
]

{ #category : #accessing }
BlSpartaSkiaCanvasBuilder class >> priority [
	^ 10
]

{ #category : #testing }
BlSpartaSkiaCanvasBuilder class >> supportsBufferSurface [
	"Return true if this canvas builder can work with a buffer surface, false otherwise"
	<return: #Boolean>
	
	^ false
]

{ #category : #testing }
BlSpartaSkiaCanvasBuilder class >> supportsFormSurface [
	"Return true if this canvas builder can work with form surface, false otherwise"
	<return: #Boolean>
	
	^ false
]

{ #category : #testing }
BlSpartaSkiaCanvasBuilder class >> supportsOpenGLSurface [
	"Return true if this renderer can work with OpenGL surface, false otherwise"
	<return: #Boolean>
	
	^ true
]

{ #category : #'instance creation' }
BlSpartaSkiaCanvasBuilder >> forBufferOn: aRendererSurface [
	<return: #SpartaCanvas>
	
	^ self shouldNotImplement
]

{ #category : #'instance creation' }
BlSpartaSkiaCanvasBuilder >> forFormOn: aRendererSurface [
	<return: #SpartaCanvas>
	
	^ self shouldNotImplement
]

{ #category : #'instance creation' }
BlSpartaSkiaCanvasBuilder >> forOpenGLOn: aRendererSurface [
	<return: #SpartaCanvas>
	^ (self class environment at: #SkiaCanvas)
		extent:
			aRendererSurface logicalSize width
				@ aRendererSurface logicalSize height
		renderExtent:
			aRendererSurface physicalSize width
				@ aRendererSurface physicalSize height
]
