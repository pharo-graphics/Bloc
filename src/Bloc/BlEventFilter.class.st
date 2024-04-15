Class {
	#name : #BlEventFilter,
	#superclass : #BlBasicEventHandler,
	#instVars : [
		'eventClass'
	],
	#category : #'Bloc-Events-Handler'
}

{ #category : #'instance creation' }
BlEventFilter class >> on: anEventClass [
	<return: #BlEventFilter>

	^ self new eventClass: anEventClass
]

{ #category : #'private - accessing' }
BlEventFilter >> eventClass [
	<return: #'BlEvent class'>

	^ eventClass
]

{ #category : #'private - accessing' }
BlEventFilter >> eventClass: aBlEventClass [
	self
		assert: [ eventClass isNil ]
		description: [ 'Filter event class can not be changed once set' ].

	eventClass := aBlEventClass
]

{ #category : #'api - accessing' }
BlEventFilter >> eventsToHandle [
	^ { self eventClass }
]

{ #category : #'api - event managing' }
BlEventFilter >> handleEvent: anEvent [

	anEvent consume
]

{ #category : #printing }
BlEventFilter >> printOn: aStream [
	aStream
		nextPutAll: 'Event filter of ';
		nextPutAll: self eventClass name
]

{ #category : #'api - event managing' }
BlEventFilter >> wantsEvent: anEvent [
	^ anEvent class == self eventClass or: [ anEvent class inheritsFrom: self eventClass ]
]
