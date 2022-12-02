Class {
	#name : #BlSpaceMouseDownOutsideEvent,
	#superclass : #BlSpaceEvent,
	#instVars : [
		'event'
	],
	#category : #'Bloc-Events-Type-Space'
}

{ #category : #accessing }
BlSpaceMouseDownOutsideEvent >> event [

	^ event
]

{ #category : #accessing }
BlSpaceMouseDownOutsideEvent >> event: aBlEvent [

	event := aBlEvent
]
