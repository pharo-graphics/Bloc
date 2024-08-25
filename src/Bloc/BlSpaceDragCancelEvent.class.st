Class {
	#name : #BlSpaceDragCancelEvent,
	#superclass : #BlSpaceEvent,
	#instVars : [
		'position'
	],
	#category : #'Bloc-Events-Type-Space'
}

{ #category : #accessing }
BlSpaceDragCancelEvent >> position [
	^ position
]

{ #category : #accessing }
BlSpaceDragCancelEvent >> position: anObject [
	position := anObject
]

{ #category : #sending }
BlSpaceDragCancelEvent >> sendTo: anObject [
	anObject spaceDragCancelEvent: self
]
