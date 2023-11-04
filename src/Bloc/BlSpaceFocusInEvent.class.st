"
Is sent to the space when a window receives focus

"
Class {
	#name : 'BlSpaceFocusInEvent',
	#superclass : 'BlSpaceEvent',
	#package : 'Bloc',
	#tag : 'Events-Type-Space'
}

{ #category : 'sending' }
BlSpaceFocusInEvent >> sendTo: anObject [
	anObject spaceFocusInEvent: self
]
