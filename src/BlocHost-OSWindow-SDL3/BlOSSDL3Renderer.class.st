Class {
	#name : #BlOSSDL3Renderer,
	#superclass : #OSWindowRenderer,
	#category : #'BlocHost-OSWindow-SDL3'
}

{ #category : #'instance creation' }
BlOSSDL3Renderer class >> for: aSDL3BackendWindow [

	^ self basicNew
		initializeWith: aSDL3BackendWindow;
		yourself
]

{ #category : #accessing }
BlOSSDL3Renderer class >> hostSpaceClass [

	^ self subclassResponsibility
]

{ #category : #'instance creation' }
BlOSSDL3Renderer class >> new [

	self error: 'Use #for:'
]

{ #category : #'updating screen' }
BlOSSDL3Renderer >> exposed [
]

{ #category : #'updating screen' }
BlOSSDL3Renderer >> flush [
]

{ #category : #initialization }
BlOSSDL3Renderer >> initializeWith: aSDL3BackendWindow [

	self initialize.
	self backendWindow: aSDL3BackendWindow
]

{ #category : #'updating screen' }
BlOSSDL3Renderer >> present [
]

{ #category : #'updating screen' }
BlOSSDL3Renderer >> resized [
]

{ #category : #'updating screen' }
BlOSSDL3Renderer >> updateAll [

	self shouldNotImplement
]

{ #category : #'updating screen' }
BlOSSDL3Renderer >> updateRectangle: aRectangle [

	self shouldNotImplement
]

{ #category : #'updating screen' }
BlOSSDL3Renderer >> updateRectangles: allDamage [

	self shouldNotImplement
]
