"
I represent events happened to a `BlSpace`.
"
Class {
	#name : #BlSpaceEvent,
	#superclass : #BlEvent,
	#category : #'Bloc-Events-Type-Space'
}

{ #category : #testing }
BlSpaceEvent >> isSpaceEvent [

	^ true
]

{ #category : #testing }
BlSpaceEvent >> isSpaceResizedEvent [

	^ false
]

{ #category : #sending }
BlSpaceEvent >> sendTo: anObject [

	anObject spaceEvent: self
]
