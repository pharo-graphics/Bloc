"
I am sent by an element with applied Resizer Listener after the resizing target was resized
"
Class {
	#name : #BlResizerResizedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'extent'
	],
	#category : #'Bloc-Utilities - Resizable'
}

{ #category : #accessing }
BlResizerResizedEvent >> extent [
	^ extent
]

{ #category : #accessing }
BlResizerResizedEvent >> extent: aPoint [
	extent := aPoint
]
