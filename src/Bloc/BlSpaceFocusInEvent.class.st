Class {
	#name : #BlSpaceFocusInEvent,
	#superclass : #BlSpaceEvent,
	#category : #'Bloc-Events'
}

{ #category : #sending }
BlSpaceFocusInEvent >> sendTo: anObject [
	anObject spaceFocusInEvent: self
]
