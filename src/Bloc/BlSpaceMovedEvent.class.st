Class {
	#name : 'BlSpaceMovedEvent',
	#superclass : 'BlSpaceEvent',
	#instVars : [
		'position'
	],
	#package : 'Bloc',
	#tag : 'Events-Type-Space'
}

{ #category : 'accessing' }
BlSpaceMovedEvent >> position [
	^ position
]

{ #category : 'accessing' }
BlSpaceMovedEvent >> position: anObject [
	position := anObject
]

{ #category : 'sending' }
BlSpaceMovedEvent >> sendTo: anObject [
	anObject spaceMovedEvent: self
]
