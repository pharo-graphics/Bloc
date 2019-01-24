Class {
	#name : #BlSpaceFocusOutEvent,
	#superclass : #BlSpaceEvent,
	#category : #'Bloc-Events'
}

{ #category : #'as yet unclassified' }
BlSpaceFocusOutEvent >> sendTo: anObject [
	anObject spaceFocusOutEvent: self
]
