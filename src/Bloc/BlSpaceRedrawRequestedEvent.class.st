Class {
	#name : 'BlSpaceRedrawRequestedEvent',
	#superclass : 'BlSpaceEvent',
	#category : 'Bloc-Events-Type-Space',
	#package : 'Bloc',
	#tag : 'Events-Type-Space'
}

{ #category : 'accessing' }
BlSpaceRedrawRequestedEvent >> sendTo: anObject [
	anObject spaceRedrawRequestedEvent: self
]
