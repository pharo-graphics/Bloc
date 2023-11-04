"
I am a {{gtClass:BlBasicEventHandler}}.
I am used by {{gtClass:BlDevScripter}}.
I collect events into {{gtMethod:BlDevScripter>>#events}}.

"
Class {
	#name : 'BlDevScripterEventCollectorHandler',
	#superclass : 'BlBasicEventHandler',
	#instVars : [
		'scripter'
	],
	#category : 'Bloc-Scripter-Scripter-Utilities',
	#package : 'Bloc-Scripter',
	#tag : 'Scripter-Utilities'
}

{ #category : 'comparing' }
BlDevScripterEventCollectorHandler >> = anotherObject [
	self species == anotherObject species
		ifFalse: [ ^ false ].

	^ anotherObject scripter = self scripter
]

{ #category : 'api - accessing' }
BlDevScripterEventCollectorHandler >> eventsToHandle [
	^ { BlEvent }
]

{ #category : 'api - event managing' }
BlDevScripterEventCollectorHandler >> handleEvent: anEvent [
	self scripterDo: [ :aScripter | aScripter events add: anEvent ]
]

{ #category : 'comparing' }
BlDevScripterEventCollectorHandler >> hash [
	^ self scripter hash
]

{ #category : 'printing' }
BlDevScripterEventCollectorHandler >> printOn: aStream [
	aStream
		nextPutAll: 'Scripter event handler of ';
		nextPutAll: BlEvent name
]

{ #category : 'api - accessing' }
BlDevScripterEventCollectorHandler >> scripter [
	<return: #BlDevScripter>
	^ scripter
]

{ #category : 'api - accessing' }
BlDevScripterEventCollectorHandler >> scripter: aBlDevScripter [
	scripter := aBlDevScripter
]

{ #category : 'api - accessing' }
BlDevScripterEventCollectorHandler >> scripterDo: aBlock [
	self scripter ifNotNil: aBlock
]

{ #category : 'api - event managing' }
BlDevScripterEventCollectorHandler >> wantsEvent: anEvent [
	^ true
]
