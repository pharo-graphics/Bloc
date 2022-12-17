"
Is sent to the space when mouse cursor leaves the window

"
Class {
	#name : #BlSpaceMouseLeaveEvent,
	#superclass : #BlSpaceEvent,
	#category : #'Bloc-Events-Type-Space'
}

{ #category : #sending }
BlSpaceMouseLeaveEvent >> sendTo: anObject [
	anObject spaceMouseLeaveEvent: self
]
