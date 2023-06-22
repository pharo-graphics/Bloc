Class {
	#name : #BlSpaceMouseDownOutsideEvent,
	#superclass : #BlSpaceEvent,
	#instVars : [
		'originalEvent'
	],
	#category : #'Bloc-Events-Type-Space'
}

{ #category : #accessing }
BlSpaceMouseDownOutsideEvent >> originalEvent [

	^ originalEvent
]

{ #category : #accessing }
BlSpaceMouseDownOutsideEvent >> originalEvent: aBlEvent [

	aBlEvent consumed: true.
	originalEvent := aBlEvent
]
