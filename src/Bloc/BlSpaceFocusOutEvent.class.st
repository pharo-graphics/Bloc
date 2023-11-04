"
Is sent to the space when a window loses focus

"
Class {
	#name : 'BlSpaceFocusOutEvent',
	#superclass : 'BlSpaceEvent',
	#package : 'Bloc',
	#tag : 'Events-Type-Space'
}

{ #category : 'sending' }
BlSpaceFocusOutEvent >> sendTo: anObject [
	anObject spaceFocusOutEvent: self
]
