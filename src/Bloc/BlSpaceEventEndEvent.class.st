Class {
	#name : #BlSpaceEventEndEvent,
	#superclass : #BlSpaceStepEvent,
	#category : #'Bloc-Events'
}

{ #category : #sending }
BlSpaceEventEndEvent >> sendTo: anObject [
	anObject spaceEventProcessedEvent: self
]
