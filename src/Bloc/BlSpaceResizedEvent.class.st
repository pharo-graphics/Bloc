Class {
	#name : 'BlSpaceResizedEvent',
	#superclass : 'BlSpaceEvent',
	#instVars : [
		'extent'
	],
	#category : 'Bloc-Events-Type-Space',
	#package : 'Bloc',
	#tag : 'Events-Type-Space'
}

{ #category : 'accessing' }
BlSpaceResizedEvent >> extent [
	"Return window size in screen coordinates"
	^ extent
]

{ #category : 'accessing' }
BlSpaceResizedEvent >> extent: anObject [
	extent := anObject
]

{ #category : 'testing' }
BlSpaceResizedEvent >> isSpaceResizedEvent [
	^ true
]

{ #category : 'sending' }
BlSpaceResizedEvent >> sendTo: anObject [
	anObject spaceResizedEvent: self
]
