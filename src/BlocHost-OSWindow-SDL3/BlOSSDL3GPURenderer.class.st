Class {
	#name : #BlOSSDL3GPURenderer,
	#superclass : #BlOSSDL3Renderer,
	#instVars : [
		'formRenderer',
		'form'
	],
	#category : #'BlocHost-OSWindow-SDL3'
}

{ #category : #accessing }
BlOSSDL3GPURenderer class >> hostSpaceClass [
	^ BlOSSDL3GPUHostSpace
]

{ #category : #'host space - accessing' }
BlOSSDL3GPURenderer >> canvasExtent [

	^ formRenderer outputExtent
]

{ #category : #'updating screen' }
BlOSSDL3GPURenderer >> flush [

	formRenderer flush
]

{ #category : #accessing }
BlOSSDL3GPURenderer >> form [

	^ form
]

{ #category : #accessing }
BlOSSDL3GPURenderer >> form: aForm [

	form := aForm.
	formRenderer form: aForm
]

{ #category : #accessing }
BlOSSDL3GPURenderer >> formRenderer [

	^ formRenderer
]

{ #category : #initialization }
BlOSSDL3GPURenderer >> initializeWith: aSDL3BackendWindow [

	super initializeWith: aSDL3BackendWindow.
	formRenderer := OSSDL3GPUFormRenderer new.
	formRenderer backendWindow: aSDL3BackendWindow.
	"Use canvasExtent (physical pixels) for the backing Form on High-DPI"
	self form: (Form extent: aSDL3BackendWindow canvasExtent depth: 32)
]

{ #category : #'updating screen' }
BlOSSDL3GPURenderer >> present [

	self flush
]

{ #category : #'updating screen' }
BlOSSDL3GPURenderer >> resized [
	"Recreate the backing form when the window is resized"
	self form: (Form extent: backendWindow canvasExtent depth: 32).
	formRenderer updateToNewResolution
]

{ #category : #'updating screen' }
BlOSSDL3GPURenderer >> updateRectangle: aRectangle [

	formRenderer updateRectangle: aRectangle
]
