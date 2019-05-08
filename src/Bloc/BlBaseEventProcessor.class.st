Class {
	#name : #BlBaseEventProcessor,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'space'
	],
	#category : #'Bloc-Space-Support'
}

{ #category : #'as yet unclassified' }
BlBaseEventProcessor class >> space:  aSpace [
	^ self new
		space: aSpace;
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

{ #category : #accessing }
BlBaseEventProcessor >> space [
	^ space
]

{ #category : #accessing }
BlBaseEventProcessor >> space: aSpace [
	space := aSpace
]
