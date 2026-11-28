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

{ #category : #deleting }
BlOSSDL3GPURenderer >> destroy [

	formRenderer destroy.

	super destroy
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
	form := Form extent: aSDL3BackendWindow canvasExtent depth: 32.
	formRenderer :=
		aSDL3BackendWindow driver
			newFormRenderer: form
			backendWindow: aSDL3BackendWindow
]

{ #category : #testing }
BlOSSDL3GPURenderer >> needsFlush [

	^ formRenderer needsFlush
]

{ #category : #'updating screen' }
BlOSSDL3GPURenderer >> present [

	self flush
]

{ #category : #'updating screen' }
BlOSSDL3GPURenderer >> resized [
	"Recreate the backing form when the window pixel extent changes."

	| newExtent |
	newExtent := backendWindow canvasExtent.
	"Skip zero-sized extents (for example, while a window is minimized)."
	(newExtent x <= 0 or: [ newExtent y <= 0 ]) ifTrue: [ ^ self ].
	"Keep the current form when the extent did not change (for example, on the first frame)."
	(form isNotNil and: [ form extent = newExtent ]) ifTrue: [ ^ self ].
	self form: (Form extent: newExtent depth: 32).
	formRenderer updateToNewResolution
]

{ #category : #updating }
BlOSSDL3GPURenderer >> updateGPUDevice: aGPUDevice [
	"Forward GPU device lifecycle updates (such as driver shutdown or restart) to formRenderer."

	formRenderer ifNotNil: [ formRenderer updateGPUDevice: aGPUDevice ]
]

{ #category : #'updating screen' }
BlOSSDL3GPURenderer >> updateRectangle: aRectangle [

	formRenderer updateRectangle: aRectangle
]
