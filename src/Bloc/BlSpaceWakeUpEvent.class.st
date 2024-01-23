Class {
	#name : #BlSpaceWakeUpEvent,
	#superclass : #BlSpaceEvent,
	#category : 'Bloc-Events-Type-Space'
}

{ #category : #sending }
BlSpaceWakeUpEvent >> sendTo: anObject [
	anObject spaceWakeUpEvent: self
]
