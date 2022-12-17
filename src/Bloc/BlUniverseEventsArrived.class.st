"
Emitted when new events arrive from the OS to be processed by Universe

"
Class {
	#name : #BlUniverseEventsArrived,
	#superclass : #BlUniverseEvent,
	#instVars : [
		'cause'
	],
	#category : #'Bloc-Events-Type-Universe'
}

{ #category : #accessing }
BlUniverseEventsArrived >> cause [
	^ cause
]

{ #category : #accessing }
BlUniverseEventsArrived >> cause: anObject [
	cause := anObject
]

{ #category : #sending }
BlUniverseEventsArrived >> sendTo: anObject [
	anObject universeEventsArrived: self
]
