Class {
	#name : #BlSpaceDragCancelEvent,
	#superclass : #BlSpaceEvent,
	#instVars : [
		'delegate',
		'position'
	],
	#category : #'Bloc-Events-Type-Space'
}

{ #category : #accessing }
BlSpaceDragCancelEvent >> delegate [
	^ delegate
]

{ #category : #accessing }
BlSpaceDragCancelEvent >> delegate: anObject [
	delegate := anObject
]

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
