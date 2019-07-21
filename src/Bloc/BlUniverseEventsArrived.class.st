"
Emitted when new events arrive from the OS to be processed by Universe
"
Class {
	#name : #BlUniverseEventsArrived,
	#superclass : #BlUniverseEvent,
	#instVars : [
		'cause'
	],
	#category : #'Bloc-Events'
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
	anObject eventsArrived: self
]
