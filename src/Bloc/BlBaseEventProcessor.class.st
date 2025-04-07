"
My subclasses process `BlEvent`s and provide an API that spaces and space hosts send.
"
Class {
	#name : #BlBaseEventProcessor,
	#superclass : #Object,
	#instVars : [
		'space'
	],
	#category : #'Bloc-Space - Events'
}

{ #category : #'instance creation' }
BlBaseEventProcessor class >> space: aSpace [

	^ self basicNew
		initializeWithSpace: aSpace;
		yourself
]

{ #category : #'event firing' }
BlBaseEventProcessor >> dispatchEvent: anEvent target: aTarget [

	anEvent fillFromTime: space time.

	aTarget dispatchEvent: anEvent
]

{ #category : #'event firing' }
BlBaseEventProcessor >> fireEvent: anEvent [

	anEvent fillFromTime: space time.
	
	^ BlEvent fireEvent: anEvent
]

{ #category : #'event firing' }
BlBaseEventProcessor >> fireEvent: anEvent from: aTopEventTarget [

	anEvent fillFromTime: space time.

	^ BlEvent fireEvent: anEvent from: aTopEventTarget
]

{ #category : #accessing }
BlBaseEventProcessor >> initializeWithSpace: aSpace [

	space := aSpace.

	"Initialization in subclasses may need the space"
	self initialize
]

{ #category : #'initialize-release' }
BlBaseEventProcessor >> onSpaceClosed [
	"React to space closed in order to clean up the state"
]

{ #category : #accessing }
BlBaseEventProcessor >> space [

	^ space
]
