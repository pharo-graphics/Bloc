Class {
	#name : #BlSpaceMouseLeaveEvent,
	#superclass : #BlSpaceEvent,
	#category : #'Bloc-Events'
}

{ #category : #'as yet unclassified' }
BlSpaceMouseLeaveEvent >> sendTo: anObject [
	anObject spaceMouseLeaveEvent: self
]
