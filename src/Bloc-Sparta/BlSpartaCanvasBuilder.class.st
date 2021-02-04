"
I construct a sparta canvas
"
Class {
	#name : #BlSpartaCanvasBuilder,
	#superclass : #Object,
	#category : 'Bloc-Sparta'
}

{ #category : #'api - instance creation' }
BlSpartaCanvasBuilder class >> extent: aPoint [
	"Create a default canvas of a given size that should be used for output on screen"
	<return: #SpartaCanvas>
	
	^ self subclassResponsibility
]

{ #category : #accessing }
BlSpartaCanvasBuilder class >> isSupported [
	<return: #Boolean>
	
	^ self subclassResponsibility
]

{ #category : #accessing }
BlSpartaCanvasBuilder class >> label [
	<return: #String>
	^ self subclassResponsibility
]

{ #category : #'instance creation' }
BlSpartaCanvasBuilder class >> offscreen [
	<return: #SpartaCanvas>

	^ self subclassResponsibility
]

{ #category : #'api - instance creation' }
BlSpartaCanvasBuilder class >> pdf: aFileName extent: aPoint [
	"Create a canvas for pdf output of a given size"
	<return: #SpartaCanvas>
	
	^ self subclassResponsibility
]

{ #category : #accessing }
BlSpartaCanvasBuilder class >> priority [
	"Return sparta canvas builder priority as positive number which influences builder order
	and selection of a default canvas.
	Lower value - more likely canvas becomes a default"
	<return: #Number>

	^ self subclassResponsibility
]

{ #category : #testing }
BlSpartaCanvasBuilder class >> supportsBufferSurface [
	"Return true if this canvas builder can work with a buffer surface, false otherwise"
	<return: #Boolean>
	
	^ self subclassResponsibility
]

{ #category : #testing }
BlSpartaCanvasBuilder class >> supportsFormSurface [
	"Return true if this canvas builder can work with form surface, false otherwise"
	<return: #Boolean>
	
	^ self subclassResponsibility
]

{ #category : #testing }
BlSpartaCanvasBuilder class >> supportsOpenGLSurface [
	"Return true if this renderer can work with OpenGL surface, false otherwise"
	<return: #Boolean>
	
	^ self subclassResponsibility
]

{ #category : #'api - instance creation' }
BlSpartaCanvasBuilder class >> svg: aFileName extent: aPoint [
	"Create a canvas for svg output of a given size"
	<return: #SpartaCanvas>
	
	^ self subclassResponsibility
]

{ #category : #accessing }
BlSpartaCanvasBuilder >> extent: anExtent [
	^ self class extent: anExtent
]

{ #category : #'instance creation' }
BlSpartaCanvasBuilder >> forBufferOn: aRendererSurface [
	<return: #SpartaCanvas>
	
	^ self subclassResponsibility
]

{ #category : #'instance creation' }
BlSpartaCanvasBuilder >> forFormOn: aRendererSurface [
	<return: #SpartaCanvas>
	
	^ self subclassResponsibility
]

{ #category : #'instance creation' }
BlSpartaCanvasBuilder >> forOpenGLOn: aRendererSurface [
	<return: #SpartaCanvas>
	
	^ self subclassResponsibility
]

{ #category : #accessing }
BlSpartaCanvasBuilder >> label [
	^ self class label
]

{ #category : #accessing }
BlSpartaCanvasBuilder >> offscreen [
	^ self class offscreen
]
