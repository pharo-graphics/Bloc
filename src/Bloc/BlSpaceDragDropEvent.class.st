"
Is sent by the space when an element is being dropped
"
Class {
	#name : #BlSpaceDragDropEvent,
	#superclass : #BlSpaceDragWithElementEvent,
	#category : #'Bloc-Events-Type-Space'
}

{ #category : #sending }
BlSpaceDragDropEvent >> sendTo: anObject [
	anObject spaceDragDropEvent: self
]
