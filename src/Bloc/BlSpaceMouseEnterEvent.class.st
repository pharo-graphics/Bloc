"
Is sent to the space when mouse cursor enters the window

"
Class {
	#name : #BlSpaceMouseEnterEvent,
	#superclass : #BlSpaceEvent,
	#category : 'Bloc-Events-Type-Space'
}

{ #category : #sending }
BlSpaceMouseEnterEvent >> sendTo: anObject [
	anObject spaceMouseEnterEvent: self
]
