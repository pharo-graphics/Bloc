Class {
	#name : #BlSpaceEventProcessEndEvent,
	#superclass : #BlSpaceStepEvent,
	#category : 'Bloc-Event'
}

{ #category : #sending }
BlSpaceEventProcessEndEvent >> sendTo: anObject [
	anObject spaceEventProcessedEvent: self
]
