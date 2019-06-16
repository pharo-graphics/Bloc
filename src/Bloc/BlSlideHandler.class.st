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

	anEvent currentTarget children accountedByLayout do: [ :aChild | aChild relocate: aChild position + aSlideDelta ].
	dragStartPosition := anEvent localPosition.
]

{ #category : #'dnd handlers' }
BlSlideHandler >> dragStartEvent: anEvent [
	anEvent consumed: true.

	"drag start position in local"
	dragStartPosition := anEvent localPosition.
]

{ #category : #'dnd handlers' }
BlSlideHandler >> scrollEvent: anEvent [
	| aDelta |
	
	aDelta := anEvent vector x negated @ anEvent vector y.
	
	anEvent currentTarget children accountedByLayout do: [ :aChild | aChild relocate: aChild measuredPosition + aDelta ].
]
