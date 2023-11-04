Class {
	#name : 'BlSpaceRedrawRequestedEvent',
	#superclass : 'BlSpaceEvent',
	#package : 'Bloc',
	#tag : 'Events-Type-Space'
}

{ #category : 'accessing' }
BlSpaceRedrawRequestedEvent >> sendTo: anObject [
	anObject spaceRedrawRequestedEvent: self
]
