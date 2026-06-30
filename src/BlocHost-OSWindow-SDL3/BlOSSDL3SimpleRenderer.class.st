"
I am a Bloc OSWindow renderer which uses SDL3.
"
Class {
	#name : #BlOSSDL3SimpleRenderer,
	#superclass : #BlOSSDL3Renderer,
	#instVars : [
		'sdlRenderer'
	],
	#pools : [
		'SDL3Typedef'
	],
	#category : #'BlocHost-OSWindow-SDL3'
}

{ #category : #accessing }
BlOSSDL3SimpleRenderer class >> hostSpaceClass [

	^ BlOSSDL3SimpleHostSpace
]

{ #category : #'host space - accessing' }
BlOSSDL3SimpleRenderer >> canvasExtent [

	^ sdlRenderer outputExtent
]

{ #category : #deleting }
BlOSSDL3SimpleRenderer >> destroy [

	sdlRenderer destroy.

	super destroy
]

{ #category : #initialization }
BlOSSDL3SimpleRenderer >> initializeWith: aSDL3BackendWindow [

	super initializeWith: aSDL3BackendWindow.

	sdlRenderer := aSDL3BackendWindow sdlWindow newRenderer
]

{ #category : #accessing }
BlOSSDL3SimpleRenderer >> sdlRenderer [

	^ sdlRenderer
]
