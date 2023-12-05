Class {
	#name : 'BlSpaceEventsProcessedEvent',
	#superclass : 'BlSpaceStepEvent',
	#category : 'Bloc-Events-Type-Space',
	#package : 'Bloc',
	#tag : 'Events-Type-Space'
}

{ #category : 'sending' }
BlSpaceEventsProcessedEvent >> sendTo: anObject [
	anObject spaceEventsProcessedEvent: self
]
