Class {
	#name : #BlSlideHandler,
	#superclass : #BlElementEventListener,
	#instVars : [
		'originalPosition',
		'dragStartPosition'
	],
	#category : #'Bloc-Utilities - Drag&Drop'
}

{ #category : #'dnd handlers' }
BlSlideHandler >> dragEvent: anEvent [
	| aSlideDelta |
	anEvent consumed: true.
	
	aSlideDelta := anEvent localPosition - dragStartPosition.

	anEvent currentTarget childrenDo: [ :aChild | aChild relocate: aChild position + aSlideDelta ].
	dragStartPosition := anEvent localPosition.
]

{ #category : #'dnd handlers' }
BlSlideHandler >> dragStartEvent: anEvent [
	anEvent consumed: true.

	"drag start position in local"
	dragStartPosition := anEvent localPosition.
]
