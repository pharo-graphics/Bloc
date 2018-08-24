Class {
	#name : #BlSpaceDragLiftEvent,
	#superclass : #BlSpaceEvent,
	#instVars : [
		'delegate',
		'position'
	],
	#category : 'Bloc-Event'
}

{ #category : #accessing }
BlSpaceDragLiftEvent >> delegate [
	^ delegate
]

{ #category : #accessing }
BlSpaceDragLiftEvent >> delegate: anObject [
	delegate := anObject
]

{ #category : #accessing }
BlSpaceDragLiftEvent >> position [
	^ position
]

{ #category : #accessing }
BlSpaceDragLiftEvent >> position: anObject [
	position := anObject
]

{ #category : #sending }
BlSpaceDragLiftEvent >> sendTo: anObject [
	anObject spaceDragLift: self
]
