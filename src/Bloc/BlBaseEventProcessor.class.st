Class {
	#name : #BlBaseEventProcessor,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
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
	aTarget dispatchEvent: anEvent
]

{ #category : #'event firing' }
BlBaseEventProcessor >> fireEvent: anEvent [
	<return: #BlEvent>

	^ BlEvent fireEvent: anEvent
]

{ #category : #'event firing' }
BlBaseEventProcessor >> fireEvent: anEvent from: aTopEventTarget [
	<return: #BlEvent>

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
