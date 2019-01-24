Class {
	#name : #BlSpaceEvent,
	#superclass : #BlEvent,
	#category : #'Bloc-Events'
}

{ #category : #testing }
BlSpaceEvent >> isSpaceCloseRequest [
	^ false
]

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
