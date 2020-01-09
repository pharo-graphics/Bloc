"
Host renderer is resposible for the overall rendering logic
"
Class {
	#name : #BlHostRenderer,
	#superclass : #Object,
	#instVars : [
		'session',
		'surface',
		'surfaceRenderer',
		'spaceRenderer'
	],
	#category : #'Bloc-Universe - Renderer'
}

{ #category : #'instance creation' }
BlHostRenderer class >> forHostSpace: aHostSpace [
	^ self basicNew
		initialize;
		initializeForHostSpace: aHostSpace
]

{ #category : #rendering }
BlHostRenderer >> finishedRender: aSpace [
	"Perform neccessary actions after rendering is complete.
	By default I clear dirty areas of a given space"

	aSpace clearDirtyAreas
]

{ #category : #testing }
BlHostRenderer >> hasResized: aHostSpace [
	"Return true if host space resized since previous frame, otherwise false"
	<return: #Boolean>
	
	"we are not yet initialized"
	self isValid
		ifFalse: [ ^ true ].
	
	"check if the size changed"
	^ aHostSpace physicalSize ~= surface physicalSize
		or: [ aHostSpace scaleFactor ~= surface scaleFactor ]
]

{ #category : #initialization }
BlHostRenderer >> initializeForHostSpace: aBlHostSpace [
	"Initialize this renderer for a given host space.
	Please note, that it I be called multiple times"
	
	self subclassResponsibility
]

{ #category : #testing }
BlHostRenderer >> isRenderNeeded: aSpace [
	"Return true if I need to render a given space.
	By default I check if there are any dirty areas, if there are none - no need to render"
	<return: #Boolean>

	^ aSpace dirtyAreas notEmpty
]

{ #category : #testing }
BlHostRenderer >> isValid [
	<return: #Boolean>

	session == Smalltalk session
		ifFalse: [ ^ false ].

	(surface isNil
		or: [ surfaceRenderer isNil
			or: [ spaceRenderer isNil ] ])
		ifTrue: [ ^ false ].
	
	^ true
]

{ #category : #rendering }
BlHostRenderer >> render: aHostSpace [
	"Render a given space according to its dirty areas.
	Note: if there are no dirty areas nothing will happen, including window or canvas update"
	| aSpace |
	
	aSpace := aHostSpace space.

	(self isRenderNeeded: aSpace)
		ifFalse: [ ^ self ].

	self isValid
		ifFalse: [ ^ self ].

	[ | theDamagedRectangles |
		aHostSpace makeCurrent.
		theDamagedRectangles := spaceRenderer renderSpace: aSpace.
		surfaceRenderer renderSurface: surface damaged: theDamagedRectangles ]
			ensure: [ self finishedRender: aSpace ]
]
