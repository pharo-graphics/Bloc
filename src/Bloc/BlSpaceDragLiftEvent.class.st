"
Is sent by the space when a dragged element is moved (lifted) by the mouse
"
Class {
	#name : #BlSpaceDragLiftEvent,
	#superclass : #BlSpaceDragWithDelegateEvent,
	#category : #'Bloc-Events-Type-Space'
}

{ #category : #accessing }
BlSpaceDragLiftEvent >> sendTo: anObject [

	anObject spaceDragLiftEvent: self
]
