Class {
	#name : #BlSpaceMouseLeaveEvent,
	#superclass : #BlSpaceEvent,
	#category : 'Bloc-Event'
}

{ #category : #'as yet unclassified' }
BlSpaceMouseLeaveEvent >> sendTo: anObject [
	anObject spaceMouseLeaveEvent: self
]
