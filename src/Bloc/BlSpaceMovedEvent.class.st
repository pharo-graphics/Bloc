Class {
	#name : #BlSpaceMovedEvent,
	#superclass : #BlSpaceEvent,
	#instVars : [
		'position'
	],
	#category : #'Bloc-Events-Type-Space'
}

{ #category : #accessing }
BlSpaceMovedEvent >> position [
	^ position
]

{ #category : #accessing }
BlSpaceMovedEvent >> position: anObject [
	position := anObject
]

{ #category : #sending }
BlSpaceMovedEvent >> sendTo: anObject [
	anObject spaceMovedEvent: self
]
