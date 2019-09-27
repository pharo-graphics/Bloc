Class {
	#name : #BlSpaceMouseEnterEvent,
	#superclass : #BlSpaceEvent,
	#category : #'Bloc-Events'
}

{ #category : #'as yet unclassified' }
BlSpaceMouseEnterEvent >> sendTo: anObject [
	anObject spaceMouseEnterEvent: self
]
