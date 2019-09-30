"
I am a scriptable event handler that allows users to assign a valuable action to the event of chosen type.

Example:

[[[
BlEventHandler
	on: BlClickEvent
	do: [ :anEvent | self inform: 'Click!' ]
]]]
"
Class {
	#name : #BlEventHandler,
	#superclass : #BlBasicEventHandler,
	#instVars : [
		'action',
		'eventClass'
	],
	#category : #'Bloc-Events-Handling'
}

{ #category : #'instance creation' }
BlEventHandler class >> on: anEventClass do: aBlock [
	^ self new
		eventClass: anEventClass;
		action: aBlock;
		yourself
]

{ #category : #'instance creation' }
BlEventHandler class >> on: anEventClass sendTo: anObject [
	^ self
		on: anEventClass
		do: [ :event | event sendTo: anObject ]
]

{ #category : #comparing }
BlEventHandler >> = anotherObject [
	self species == anotherObject species
		ifFalse: [ ^ false ].

	^ anotherObject eventClass = self eventClass
		and: [ anotherObject action = self action ]
]

{ #category : #'private - accessing' }
BlEventHandler >> action [
	^ action
]

{ #category : #'private - accessing' }
BlEventHandler >> action: anObject [
	action := anObject
]

{ #category : #'private - accessing' }
BlEventHandler >> eventClass [
	^ eventClass
]

{ #category : #'private - accessing' }
BlEventHandler >> eventClass: anObject [
	eventClass := anObject
]

{ #category : #'api - event managing' }
BlEventHandler >> handleEvent: anEvent [
	self action cull: anEvent
]

{ #category : #comparing }
BlEventHandler >> hash [
	^ self action hash bitXor: self eventClass hash
]

{ #category : #printing }
BlEventHandler >> printOn: aStream [
	aStream
		nextPutAll: 'Event handler of ';
		nextPutAll: self eventClass name
]

{ #category : #'api - event managing' }
BlEventHandler >> wantsEvent: anEvent [
	^ anEvent class == self eventClass or: [ anEvent class inheritsFrom: self eventClass ]
]
