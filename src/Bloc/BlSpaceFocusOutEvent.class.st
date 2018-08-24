Class {
	#name : #BlSpaceFocusOutEvent,
	#superclass : #BlSpaceEvent,
	#category : 'Bloc-Event'
}

{ #category : #'as yet unclassified' }
BlSpaceFocusOutEvent >> sendTo: anObject [
	anObject spaceFocusOutEvent: self
]
