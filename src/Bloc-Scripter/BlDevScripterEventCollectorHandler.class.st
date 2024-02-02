"
I am a `BlBasicEventHandler`.
I am used by `BlDevScripter`.
I collect events into `BlDevScripter>>#events`.

"
Class {
	#name : #BlDevScripterEventCollectorHandler,
	#superclass : #BlBasicEventHandler,
	#instVars : [
		'scripter'
	],
	#category : #'Bloc-Scripter-Scripter-Utilities'
}

{ #category : #comparing }
BlDevScripterEventCollectorHandler >> = anotherObject [

	self species == anotherObject species ifFalse: [ ^ false ].

	^ anotherObject scripter = self scripter
]

{ #category : #'api - accessing' }
BlDevScripterEventCollectorHandler >> eventsToHandle [

	^ { BlEvent }
]

{ #category : #'api - event managing' }
BlDevScripterEventCollectorHandler >> handleEvent: anEvent [

	scripter ifNil: [ ^ self ].
	scripter events add: anEvent
]

{ #category : #comparing }
BlDevScripterEventCollectorHandler >> hash [

	^ scripter hash
]

{ #category : #printing }
BlDevScripterEventCollectorHandler >> printOn: aStream [

	aStream
		nextPutAll: 'Scripter event handler of ';
		nextPutAll: BlEvent name
]

{ #category : #'api - accessing' }
BlDevScripterEventCollectorHandler >> scripter [

	^ scripter
]

{ #category : #'api - accessing' }
BlDevScripterEventCollectorHandler >> scripter: aBlDevScripter [

	scripter := aBlDevScripter
]

{ #category : #'api - event managing' }
BlDevScripterEventCollectorHandler >> wantsEvent: anEvent [

	^ true
]
