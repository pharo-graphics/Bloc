Class {
	#name : #BlSpaceMouseLeaveEvent,
	#superclass : #BlSpaceEvent,
	#category : #'Bloc-Events-Type-Space'
}

{ #category : #'as yet unclassified' }
BlSpaceMouseLeaveEvent >> sendTo: anObject [
	anObject spaceMouseLeaveEvent: self
]
