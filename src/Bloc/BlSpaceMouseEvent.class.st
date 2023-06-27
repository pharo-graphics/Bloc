Class {
	#name : #BlSpaceMouseEvent,
	#superclass : #BlSpaceEvent,
	#instVars : [
		'originalEvent'
	],
	#category : #'Bloc-Events-Type-Space'
}

{ #category : #accessing }
BlSpaceMouseEvent >> originalEvent [

	^ originalEvent
]

{ #category : #accessing }
BlSpaceMouseEvent >> originalEvent: aBlEvent [

	aBlEvent consumed: true.
	originalEvent := aBlEvent
]

{ #category : #'as yet unclassified' }
BlSpaceMouseEvent >> sendTo: anObject [

	anObject spaceMouseEvent: self
]
