"
Is sent by the space when a dragged element enter the dropped area
"
Class {
	#name : #BlSpaceDragDropEnterEvent,
	#superclass : #BlSpaceDragWithElementEvent,
	#category : #'Bloc-Events-Type-Space'
}

{ #category : #sending }
BlSpaceDragDropEnterEvent >> sendTo: anObject [
	anObject spaceDragDropEnterEvent: self
]
