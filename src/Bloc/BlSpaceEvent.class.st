Class {
	#name : 'BlSpaceEvent',
	#superclass : 'BlEvent',
	#category : 'Bloc-Events-Type-Space',
	#package : 'Bloc',
	#tag : 'Events-Type-Space'
}

{ #category : 'testing' }
BlSpaceEvent >> isSpaceCloseRequest [
	^ false
]

{ #category : 'testing' }
BlSpaceEvent >> isSpaceEvent [
	^ true
]

{ #category : 'testing' }
BlSpaceEvent >> isSpaceResizedEvent [
	^ false
]

{ #category : 'sending' }
BlSpaceEvent >> sendTo: anObject [
	anObject spaceEvent: self
]
