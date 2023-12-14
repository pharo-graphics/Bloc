Class {
	#name : 'BlSpaceDragLiftEvent',
	#superclass : 'BlSpaceEvent',
	#instVars : [
		'delegate',
		'position'
	],
	#category : 'Bloc-Events-Type-Space',
	#package : 'Bloc',
	#tag : 'Events-Type-Space'
}

{ #category : 'accessing' }
BlSpaceDragLiftEvent >> delegate [
	^ delegate
]

{ #category : 'accessing' }
BlSpaceDragLiftEvent >> delegate: anObject [
	delegate := anObject
]

{ #category : 'accessing' }
BlSpaceDragLiftEvent >> position [
	^ position
]

{ #category : 'accessing' }
BlSpaceDragLiftEvent >> position: anObject [
	position := anObject
]

{ #category : 'sending' }
BlSpaceDragLiftEvent >> sendTo: anObject [
	anObject spaceDragLiftEvent: self
]
