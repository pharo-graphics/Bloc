Class {
	#name : #BlSpaceEventsProcessedEvent,
	#superclass : #BlSpaceStepEvent,
	#category : 'Bloc-Events-Type-Space'
}

{ #category : 'sending' }
BlSpaceEventsProcessedEvent >> sendTo: anObject [
	anObject spaceEventsProcessedEvent: self
]
