Class {
	#name : 'BlSpaceWakeUpEvent',
	#superclass : 'BlSpaceEvent',
	#package : 'Bloc',
	#tag : 'Events-Type-Space'
}

{ #category : 'sending' }
BlSpaceWakeUpEvent >> sendTo: anObject [
	anObject spaceWakeUpEvent: self
]
