Class {
	#name : #BlSpaceResizedEvent,
	#superclass : #BlSpaceEvent,
	#instVars : [
		'extent'
	],
	#category : #'Bloc-Events-Type-Space'
}

{ #category : #accessing }
BlSpaceResizedEvent >> extent [
	"Return window size in screen coordinates"
	^ extent
]

{ #category : #accessing }
BlSpaceResizedEvent >> extent: anObject [
	extent := anObject
]

{ #category : #testing }
BlSpaceResizedEvent >> isSpaceResizedEvent [
	^ true
]

{ #category : #printing }
BlSpaceResizedEvent >> printOn: aStream [

	aStream
		nextPutAll: self class name;
		nextPutAll: '(timestamp: ';
		print: self timestamp;
		nextPutAll: ' extent: ';
		print: extent;
		nextPut: $)
]

{ #category : #sending }
BlSpaceResizedEvent >> sendTo: anObject [
	anObject spaceResizedEvent: self
]
