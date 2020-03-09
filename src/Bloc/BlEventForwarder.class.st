"
I forward events to another event handler while making it look like the event is sent from ==eventTarget== as current target.

I am very useful if a user want to transfer an event handler from one dispatcher to the other. It is not possible to do it directly, because then the ==currentTarget== of the received event will be different those two event dispatchers. To solve this problem ${class:BlEventForwarder}$ can reference a specific event target that will be used as ==currentTarget== for all forwarded events. This way the decorated event handler will receive events with consistent ==currentTarget==

[[[
BlEventForwarder
	forwardTo: (BlEventHandler on: BlClickEvent do: [ :anEvent | self inform: anEvent asString ])
	from: BlElement new
]]]

"
Class {
	#name : #BlEventForwarder,
	#superclass : #BlBasicEventHandler,
	#instVars : [
		'eventTarget',
		'eventHandler'
	],
	#category : #'Bloc-Events-Handler'
}

{ #category : #'instance creation' }
BlEventForwarder class >> forwardTo: anEventHandler from: anEventTarget [
	^ self new
		eventTarget: anEventTarget;
		eventHandler: anEventHandler
]

{ #category : #accessing }
BlEventForwarder >> eventHandler [
	<return: #BlBasicEventHandler>

	^ eventHandler
]

{ #category : #accessing }
BlEventForwarder >> eventHandler: aBlBasicEventHandler [
	eventHandler := aBlBasicEventHandler
]

{ #category : #accessing }
BlEventForwarder >> eventTarget [
	<return: #TBlEventTarget>

	^ eventTarget
]

{ #category : #accessing }
BlEventForwarder >> eventTarget: aTBlEventTarget [
	eventTarget := aTBlEventTarget
]

{ #category : #'api - accessing' }
BlEventForwarder >> eventsToHandle [
	^ self eventHandler eventsToHandle
]

{ #category : #'api - event managing' }
BlEventForwarder >> handleEvent: anEvent [
	| aCurrentTarget |
	
	aCurrentTarget := anEvent currentTarget.
	[
		anEvent forwardingTarget: self eventTarget.
		self eventHandler handleEvent: anEvent ] ensure: [
			anEvent currentTarget: aCurrentTarget ]
]

{ #category : #printing }
BlEventForwarder >> printOn: aStream [
	aStream
		nextPutAll: 'Forward ';
		print: self eventHandler;
		nextPutAll: ' to ';
		print: self eventTarget
]

{ #category : #'api - event managing' }
BlEventForwarder >> wantsEvent: anEvent [
	<return: #Boolean>

	^ self eventHandler wantsEvent: anEvent
]
