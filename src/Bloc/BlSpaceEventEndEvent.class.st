Class {
	#name : #BlSpaceEventEndEvent,
	#superclass : #BlSpaceStepEvent,
	#category : #'Bloc-Event'
}

{ #category : #sending }
BlSpaceEventEndEvent >> sendTo: anObject [
	anObject spaceEventProcessedEvent: self
]
