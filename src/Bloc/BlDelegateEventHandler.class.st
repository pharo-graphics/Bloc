"
I delegate all events of type ==eventClass== or ones that inherit from it to the event target.

I hold a strong reference to the event target
"
Class {
	#name : #BlDelegateEventHandler,
	#superclass : #BlBasicEventHandler,
	#instVars : [
		'eventClass',
		'eventTarget'
	],
	#category : #'Bloc-EventHandling'
}

{ #category : #'instance creation' }
BlDelegateEventHandler class >> delegate: anEventClass to: anEventTarget [
	^ self new
		eventClass: anEventClass;
		eventTarget: anEventTarget;
		yourself
]

{ #category : #accessing }
BlDelegateEventHandler >> eventClass [
	^ eventClass
]

{ #category : #accessing }
BlDelegateEventHandler >> eventClass: anObject [
	eventClass := anObject
]

{ #category : #accessing }
BlDelegateEventHandler >> eventTarget [
	^ eventTarget
]

{ #category : #accessing }
BlDelegateEventHandler >> eventTarget: anObject [
	eventTarget := anObject
]

{ #category : #'api - event managing' }
BlDelegateEventHandler >> handleEvent: anEvent [
	self eventTarget dispatchEvent: anEvent
]

{ #category : #'api - event managing' }
BlDelegateEventHandler >> wantsEvent: anEvent [
	^ anEvent class == self eventClass or: [ anEvent class inheritsFrom: self eventClass ]
]
