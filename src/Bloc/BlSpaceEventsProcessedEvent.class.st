Class {
	#name : #BlSpaceEventsProcessedEvent,
	#superclass : #BlSpacePhaseEvent,
	#category : #'Bloc-Events-Type-Space'
}

{ #category : #sending }
BlSpaceEventsProcessedEvent >> sendTo: anObject [
	anObject spaceEventsProcessedEvent: self
]
