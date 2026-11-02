"
Is sent by the space when a drag&drop movement is being cancelled
"
Class {
	#name : #BlSpaceDragCancelEvent,
	#superclass : #BlSpaceDragEvent,
	#category : #'Bloc-Events-Type-Space'
}

{ #category : #sending }
BlSpaceDragCancelEvent >> sendTo: anObject [
	anObject spaceDragCancelEvent: self
]
