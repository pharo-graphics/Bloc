"
I delegate all events of type ==eventClass== or ones that inherit from it to the event target.

I hold a strong reference to the event target
"
Class {
	#name : #BlEventDelegator,
	#superclass : #BlBasicEventHandler,
	#instVars : [
		'eventClass',
		'eventTarget'
	],
	#category : #'Bloc-Events-Handling'
}

{ #category : #'instance creation' }
BlEventDelegator class >> delegate: anEventClass to: anEventTarget [
	^ self new
		eventClass: anEventClass;
		eventTarget: anEventTarget;
		yourself
]

{ #category : #accessing }
BlEventDelegator >> eventClass [
	^ eventClass
]

{ #category : #accessing }
BlEventDelegator >> eventClass: anObject [
	eventClass := anObject
]

{ #category : #accessing }
BlEventDelegator >> eventTarget [
	^ eventTarget
]

{ #category : #accessing }
BlEventDelegator >> eventTarget: anObject [
	eventTarget := anObject
]

{ #category : #'api - event managing' }
BlEventDelegator >> handleEvent: anEvent [
	self eventTarget dispatchEvent: anEvent
]

{ #category : #'api - event managing' }
BlEventDelegator >> wantsEvent: anEvent [
	^ anEvent class == self eventClass or: [ anEvent class inheritsFrom: self eventClass ]
]
