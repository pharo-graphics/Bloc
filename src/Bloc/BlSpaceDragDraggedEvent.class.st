"
Is sent by the space when an element is being dragged
"
Class {
	#name : #BlSpaceDragDraggedEvent,
	#superclass : #BlSpaceDragWithElementEvent,
	#category : #'Bloc-Events-Type-Space'
}

{ #category : #sending }
BlSpaceDragDraggedEvent >> sendTo: anObject [
	anObject spaceDragDraggedEvent: self
]
