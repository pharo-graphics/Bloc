"
Is sent to the space when mouse cursor enters the window

"
Class {
	#name : 'BlSpaceMouseEnterEvent',
	#superclass : 'BlSpaceEvent',
	#package : 'Bloc',
	#tag : 'Events-Type-Space'
}

{ #category : 'sending' }
BlSpaceMouseEnterEvent >> sendTo: anObject [
	anObject spaceMouseEnterEvent: self
]
