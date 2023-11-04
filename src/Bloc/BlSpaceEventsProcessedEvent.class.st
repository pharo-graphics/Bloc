Class {
	#name : 'BlSpaceEventsProcessedEvent',
	#superclass : 'BlSpaceStepEvent',
	#package : 'Bloc',
	#tag : 'Events-Type-Space'
}

{ #category : 'sending' }
BlSpaceEventsProcessedEvent >> sendTo: anObject [
	anObject spaceEventsProcessedEvent: self
]
